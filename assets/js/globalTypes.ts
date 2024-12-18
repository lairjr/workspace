import type {LiveSocket} from "phoenix_live_view"

declare global {
    interface Window {
        liveSocket: LiveSocket;
        Components: Record<string, any>;
    }
}