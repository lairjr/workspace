import React from 'react';
import { GameClockState } from '../../types';

interface ClockControlsProps {
  clock_state: GameClockState;
  pushEvent: (event: string, payload: any) => void;
}

function formatTime(time: number) {
  const minutes = Math.floor(time / 60);
  const seconds = time % 60;
  return `${minutes}:${seconds}`;
}

function ClockControls({ clock_state, pushEvent }: ClockControlsProps) {
  const onStartClock = () => {
    pushEvent('update-clock-state', { state: 'running' });
  };
  const onPauseClock = () => {
    pushEvent('update-clock-state', { state: 'paused' });
  };
  return (
    <div className="columns is-multiline">
      <div className="column is-4">
        <button className="button is-info">{'<'}</button>
      </div>
      <div className="column is-4">
        <p>{clock_state.period}</p>
      </div>
      <div className="column is-4">
        <button className="button is-info">{'>'}</button>
      </div>

      <div className="column is-4">
        <button className="button is-info">{'<'}</button>
      </div>
      <div className="column is-4">{formatTime(clock_state.time)}</div>
      <div className="column is-4">
        <button className="button is-info">{'>'}</button>
      </div>

      <div className="column is-6">
        <button className="button is-info" onClick={onPauseClock}>
          Pause
        </button>
      </div>
      <div className="column is-6">
        <button className="button is-info" onClick={onStartClock}>
          Start
        </button>
      </div>
    </div>
  );
}

export default ClockControls;
