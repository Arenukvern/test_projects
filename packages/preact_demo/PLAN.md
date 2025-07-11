# Project: Guitar Tabs Audio Player

This document outlines the high-level plan for creating an audio player for guitar tabs that synchronizes a YouTube video with a tab sheet.

## 1. Core Technologies

- **Framework:** Preact with TypeScript
- **Styling:** SCSS (with BEM methodology)
- **Build Tool:** Vite

## 2. Architecture & Philosophy

We will use a modular, component-based architecture. The goal is to keep components small, focused, and reusable.

- **State Management:** We'll start with a simple, centralized state management approach using Preact's native `createContext` and `useContext` hooks. This avoids adding heavy dependencies for a focused application. The global state will manage playback status, video time, and tab data.

- **Styling:** SCSS will be organized using the BEM (Block, Element, Modifier) naming convention to ensure styles are modular, scoped, and maintainable.

### SCSS Structure (BEM)

All SCSS files will reside within a single `src/assets/scss` directory, structured as follows:

- `base/`: Global styles, resets, typography.
- `components/`: Styles for each Preact component (e.g., `_player.scss`, `_tab-sheet.scss`).
- `layout/`: Major layout structures (e.g., `_grid.scss`, `_header.scss`).
- `utils/`: Shared utilities like variables and mixins.
- `main.scss`: The entry point that imports all other SCSS partials.

## 3. Core Components

Component files will use the `.tsx` extension.

- **`App`**: The root component, responsible for the overall layout and orchestrating the other components.
- **`Player`**: A wrapper around the YouTube IFrame Player. It will handle video loading and provide an API for playback control (play, pause, seek).
- **`TabSheet`**: Displays the parsed guitar tablature. It will visually highlight the currently playing section based on data from the central state.
- **`Controls`**: Contains all user-facing controls, such as play/pause buttons and a progress/seek bar. It will dispatch actions to update the application state.

## 4. Synchronization Mechanism

The synchronization between the video and the tabs is the core feature.

- **`syncPoints`**: We will use a typed data structure to map specific timestamps in the YouTube video to corresponding measures or events in the tab sheet.
  `// Condensed snippet: type SyncPoint = { time: number; measure: number };`
- **Data Flow:**
  1.  The `Player` component will continuously report its `currentTime` to the central state.
  2.  The `TabSheet` component will listen for `currentTime` updates.
  3.  Upon receiving a new time, `TabSheet` will find the active `syncPoint` and update the UI to highlight the correct part of the tablature.

## 5. Development Roadmap

### Phase 1: Foundation (MVP) - ✅ COMPLETE

- Initialize the Vite + Preact + TypeScript project.
- Set up the SCSS file structure.
- Implement the `Player` component to embed and play a YouTube video.
- Create a static `TabSheet` component that displays a hardcoded tab.
- Build basic, unconnected `Controls`.

### Phase 2: Core Synchronization Logic - ✅ COMPLETE

- Establish the central state management context.
- Connect the `Controls` to the `Player` to manage playback.
- Implement the synchronization logic within the `TabSheet` to highlight measures based on video time.
- Make the progress bar reflect video progress and allow seeking.

### Phase 3: Polish & Features - ✅ COMPLETE

- Refine UI/UX and styling for all components.
- Migrate from deprecated Sass `@import` to `@use`.
- Develop a robust system for parsing different tab formats.
- Explore and add features like playback speed control or a song selection UI.

## 6. Key Questions

To proceed effectively, we need to clarify:

- **Tab Format:** What is the source format for the guitar tabs (e.g., plain text, MusicXML, Guitar Pro files)?
- **Sync Point Creation:** How will `syncPoints` be generated? Will they be manually created per song, or is a user-facing tool needed to create them?
