import type { ComponentChildren } from "preact";
import { createContext } from "preact";
import { useState } from "preact/hooks";

type SyncPoint = {
  time: number;
  measure: number;
};

type AppState = {
  isPlaying: boolean;
  currentTime: number;
  duration: number; // video duration in seconds
  player: any; // YouTube player instance
  syncPoints: SyncPoint[];
  playbackRate: number;
  videoId: string;
  videoTitle: string;
};

type AppContextType = {
  state: AppState;
  setState: (state: Partial<AppState>) => void;
};

export const AppContext = createContext<AppContextType | undefined>(undefined);

export function AppProvider({ children }: { children: ComponentChildren }) {
  const [state, setState] = useState<AppState>({
    isPlaying: false,
    currentTime: 0,
    duration: 0,
    player: null,
    syncPoints: [
      { time: 0, measure: 0 },
      { time: 5, measure: 1 },
      { time: 10, measure: 2 },
      { time: 15, measure: 3 },
      { time: 20, measure: 4 },
    ],
    playbackRate: 1,
    videoId: "dQw4w9WgXcQ",
    videoTitle: "",
  });

  const contextValue = {
    state,
    setState: (newState: Partial<AppState>) => {
      setState((prevState) => ({ ...prevState, ...newState }));
    },
  };

  return (
    <AppContext.Provider value={contextValue}>{children}</AppContext.Provider>
  );
}
