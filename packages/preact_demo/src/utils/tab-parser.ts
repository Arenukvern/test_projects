export type TabMeasure = string[];
export type Tab = TabMeasure[];

export function parseTab(rawTab: string): Tab {
  const lines = rawTab.trim().split("\n");
  const measures: Tab = [];
  let currentMeasure: TabMeasure = [];

  for (const line of lines) {
    if (line.trim() === "") {
      if (currentMeasure.length > 0) {
        measures.push(currentMeasure);
        currentMeasure = [];
      }
    } else {
      currentMeasure.push(line);
    }
  }

  if (currentMeasure.length > 0) {
    measures.push(currentMeasure);
  }

  return measures;
}
