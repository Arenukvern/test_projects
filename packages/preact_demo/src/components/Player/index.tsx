import { useContext, useEffect } from "preact/hooks";
import type { YouTubeEvent, YouTubePlayer } from "react-youtube";
import YouTube from "react-youtube";
import { AppContext } from "../../context/AppContext";

type PlayerProps = {
  onReady?: (player: YouTubePlayer) => void;
};

export function Player({ onReady }: PlayerProps) {
  const context = useContext(AppContext);

  if (!context) {
    return <div>Loading...</div>;
  }

  const { state, setState } = context;
  const { videoId } = state;

  const opts = {
    height: "100%",
    width: "100%",
    playerVars: {
      // https://developers.google.com/youtube/player_parameters
      autoplay: 0,
      modestbranding: 1,
    },
  };

  const handleReady = (event: YouTubeEvent) => {
    const player = event.target;
    const videoData = player.getVideoData();
    setState({
      player: player,
      duration: player.getDuration(),
      videoTitle: videoData.title,
    });
    if (onReady) {
      onReady(player);
    }
  };

  const onPlay = () => {
    setState({ isPlaying: true });
  };

  const onPause = () => {
    setState({ isPlaying: false });
  };

  useEffect(() => {
    const interval = setInterval(() => {
      if (context.state.player && context.state.isPlaying) {
        const currentTime = context.state.player.getCurrentTime();
        setState({ currentTime });
      }
    }, 100);

    return () => clearInterval(interval);
  }, [context.state.player, context.state.isPlaying]);

  return (
    <div class="player">
      <YouTube
        videoId={videoId}
        opts={opts}
        onReady={handleReady}
        onPlay={onPlay}
        onPause={onPause}
      />
    </div>
  );
}
