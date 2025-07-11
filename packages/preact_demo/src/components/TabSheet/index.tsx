import { useContext, useEffect, useRef } from "preact/hooks";
import { AppContext } from "../../context/AppContext";
import { rawTab } from "../../tabs/example";
import { parseTab } from "../../utils/tab-parser";

export function TabSheet() {
  const context = useContext(AppContext);
  const activeMeasureRef = useRef<HTMLDivElement>(null);

  if (!context) {
    return <div>Loading...</div>;
  }

  const { state } = context;
  const { currentTime, syncPoints, duration } = state;

  // Find the current measure
  let activeMeasureIndex = 0;
  for (let i = syncPoints.length - 1; i >= 0; i--) {
    if (currentTime >= syncPoints[i].time) {
      activeMeasureIndex = syncPoints[i].measure;
      break;
    }
  }

  // Calculate cursor position
  const activeMeasure = syncPoints.find(
    (p) => p.measure === activeMeasureIndex
  );
  const nextMeasure = syncPoints.find(
    (p) => p.measure === activeMeasureIndex + 1
  );
  const measureStartTime = activeMeasure ? activeMeasure.time : 0;
  const measureEndTime = nextMeasure ? nextMeasure.time : duration;
  const measureDuration = measureEndTime - measureStartTime;

  let cursorPosition = 0;
  if (measureDuration > 0) {
    const progress = (currentTime - measureStartTime) / measureDuration;
    cursorPosition = progress * 100;
  }

  useEffect(() => {
    if (activeMeasureRef.current) {
      activeMeasureRef.current.scrollIntoView({
        behavior: "smooth",
        block: "nearest",
        inline: "center",
      });
    }
  }, [activeMeasureIndex]);

  const tab = parseTab(rawTab);

  return (
    <div class="tab-sheet">
      <pre class="tab-sheet__content">
        {tab.map((measure, measureIndex) => (
          <div
            key={measureIndex}
            ref={measureIndex === activeMeasureIndex ? activeMeasureRef : null}
            class={`measure ${
              measureIndex === activeMeasureIndex ? "measure--active" : ""
            }`}
          >
            {measureIndex === activeMeasureIndex && (
              <div class="cursor" style={{ left: `${cursorPosition}%` }} />
            )}
            {measure.map((line, lineIndex) => (
              <div key={lineIndex}>{line}</div>
            ))}
          </div>
        ))}
      </pre>
    </div>
  );
}
