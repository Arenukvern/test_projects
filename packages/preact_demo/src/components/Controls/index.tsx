import { h } from "preact";
import { useContext } from "preact/hooks";
import { AppContext } from "../../context/AppContext";

export function Controls() {
  const context = useContext(AppContext);

  if (!context) {
    return <div>Loading...</div>;
  }

  const { state, setState } = context;
  const { isPlaying, player, currentTime, duration, playbackRate } = state;

  const handlePlayPause = () => {
    if (player) {
      if (isPlaying) {
        player.pauseVideo();
      } else {
        player.playVideo();
      }
    }
  };

  const handleSeek = (event: h.JSX.TargetedEvent<HTMLInputElement>) => {
    if (player) {
      const time = Number(event.currentTarget.value);
      player.seekTo(time);
      context.setState({ currentTime: time });
    }
  };

  const handlePlaybackRateChange = (
    event: h.JSX.TargetedEvent<HTMLSelectElement>
  ) => {
    const rate = Number(event.currentTarget.value);
    if (player) {
      player.setPlaybackRate(rate);
    }
    setState({ playbackRate: rate });
  };

  return (
    <div class="controls">
      <button onClick={handlePlayPause}>{isPlaying ? "Pause" : "Play"}</button>
      <input
        type="range"
        min="0"
        max={duration}
        value={currentTime}
        onInput={handleSeek}
        class="controls__progress"
      />
      <div>
        {currentTime.toFixed(2)}s / {duration.toFixed(2)}s
      </div>
      <select value={playbackRate} onChange={handlePlaybackRateChange}>
        <option value="0.25">0.25x</option>
        <option value="0.5">0.5x</option>
        <option value="0.75">0.75x</option>
        <option value="1">1x</option>
        <option value="1.25">1.25x</option>
        <option value="1.5">1.5x</option>
        <option value="1.75">1.75x</option>
        <option value="2">2x</option>
      </select>
    </div>
  );
}
