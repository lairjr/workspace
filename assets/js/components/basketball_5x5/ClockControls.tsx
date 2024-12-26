import React from 'react';
import { GameClockState } from '../../types';

interface ClockControlsProps {
  clock_state: GameClockState;
  pushEvent: (event: string, payload: any) => void;
}

function formatTime(time: number) {
  const minutes = Math.floor(time / 60);
  const seconds = time % 60;
  const minutesStr = minutes < 10 ? `0${minutes}` : minutes;
  const secondsStr = seconds < 10 ? `0${seconds}` : seconds;
  return `${minutesStr}:${secondsStr}`;
}

function ClockControls({ clock_state, pushEvent }: ClockControlsProps) {
  const onStartClock = () => {
    pushEvent('update-clock-state', { state: 'running' });
  };
  const onPauseClock = () => {
    pushEvent('update-clock-state', { state: 'paused' });
  };
  const onPeriodIncrement = () => {
    pushEvent('update-clock-time-and-period', {
      property: 'period',
      operation: 'increment',
    });
  };
  const onPeriodDecrement = () => {
    pushEvent('update-clock-time-and-period', {
      property: 'period',
      operation: 'decrement',
    });
  };
  const onTimeIncrement = () => {
    pushEvent('update-clock-time-and-period', {
      property: 'time',
      operation: 'increment',
    });
  };
  const onTimeIncrement60 = () => {
    pushEvent('update-clock-time-and-period', {
      property: 'time',
      operation: 'increment60',
    });
  };
  const onTimeDecrement = () => {
    pushEvent('update-clock-time-and-period', {
      property: 'time',
      operation: 'decrement',
    });
  };
  const onTimeDecrement60 = () => {
    pushEvent('update-clock-time-and-period', {
      property: 'time',
      operation: 'decrement60',
    });
  };
  return (
    <div className="columns is-multiline">
      <div className="column is-4">
        <button className="button is-info" onClick={onPeriodDecrement}>
          {'<'}
        </button>
      </div>
      <div className="column is-4">
        <p>{clock_state.period}</p>
      </div>
      <div className="column is-4">
        <button className="button is-info" onClick={onPeriodIncrement}>
          {'>'}
        </button>
      </div>

      <div className="column is-4">
        <button className="button is-info" onClick={onTimeDecrement60}>
          {'<<'}
        </button>
        <button className="button is-info" onClick={onTimeDecrement}>
          {'<'}
        </button>
      </div>
      <div className="column is-4">{formatTime(clock_state.time)}</div>
      <div className="column is-4">
        <button className="button is-info" onClick={onTimeIncrement}>
          {'>'}
        </button>
        <button className="button is-info" onClick={onTimeIncrement60}>
          {'>>'}
        </button>
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
