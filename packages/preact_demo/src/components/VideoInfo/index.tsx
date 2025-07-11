import { h } from "preact";
import { useContext, useState } from "preact/hooks";
import { AppContext } from "../../context/AppContext";

export function VideoInfo() {
  const context = useContext(AppContext);
  const [url, setUrl] = useState(
    `https://www.youtube.com/watch?v=${context?.state.videoId}`
  );

  if (!context) {
    return <div>Loading...</div>;
  }

  const { setState } = context;

  const extractVideoId = (youtubeUrl: string) => {
    const regex =
      /(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = youtubeUrl.match(regex);
    return match ? match[1] : null;
  };

  const handleUrlChange = (e: h.JSX.TargetedEvent<HTMLInputElement>) => {
    const newUrl = e.currentTarget.value;
    setUrl(newUrl);
    const newVideoId = extractVideoId(newUrl);
    if (newVideoId) {
      setState({ videoId: newVideoId });
    }
  };

  return (
    <div class="video-info">
      <h2 class="video-info__name">{context.state.videoTitle}</h2>
      <input
        type="text"
        value={url}
        onInput={handleUrlChange}
        class="video-info__url-input"
        placeholder="Enter YouTube URL"
      />
    </div>
  );
}
