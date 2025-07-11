import { render } from "preact";
import { App } from "./app.tsx";
import "./assets/scss/main.scss";
import { AppProvider } from "./context/AppContext.tsx";

render(
  <AppProvider>
    <App />
  </AppProvider>,
  document.getElementById("app")!
);
