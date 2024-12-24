import { HooksOptions } from 'phoenix_live_view';

export interface LiveReactBase {
  pushEvent: (event: string, payload: any) => void;
  pushEventTo: (event: string, payload: any, selector: string) => void;
  handleEvent: (event: string, callback: (payload: any) => void) => void;
}

export type LiveReact = LiveReactBase & HooksOptions;

export type InitLiveReact = () => void;

export interface LiveReactComponent {
  mounted: () => void;
  updated: () => void;
  destroyed: () => void;
}

export function initLiveReact(): void;

export function initLiveReactElement(
  element: HTMLElement,
  props?: Record<string, any>,
): { target: HTMLElement; componentClass: any };

export function renderReactComponent(
  element: HTMLElement,
  target: HTMLElement,
  componentClass: any,
  props?: Record<string, any>,
  mergeProps?: Record<string, any>,
): Record<string, any>;
