import { Controls } from "./components/Controls";
import { Player } from "./components/Player";
import { TabSheet } from "./components/TabSheet";
import { VideoInfo } from "./components/VideoInfo";
import { AppProvider } from "./context/AppContext";

export function App() {
  return (
    <AppProvider>
      <div class="app">
        <div class="central-card">
          <div class="central-card__main-content">
            <div class="central-card__player-wrapper">
              <Player />
            </div>
            <div class="central-card__tabs-wrapper">
              <VideoInfo />
              <TabSheet />
            </div>
          </div>
          <div class="central-card__controls-wrapper">
            <Controls />
          </div>
        </div>
      </div>
    </AppProvider>
  );
}
