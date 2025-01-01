import React from 'react';
import { PlayerSelection } from './Main';

interface StatsControlsProps {
  pushEvent: (event: string, payload: any) => void;
  playerSelection: PlayerSelection;
}

function StatsControls({ pushEvent, playerSelection }: StatsControlsProps) {
  const onStatUpdate = (stat: string) => () => {
    pushEvent('update-player-stat', {
      ['stat-id']: stat,
      operation: 'increment',
      ['player-id']: playerSelection.playerId,
      ['team-type']: playerSelection.teamType,
    });
  };
  return (
    <div className="controls">
      <div className="columns is-multiline">
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-success"
            onClick={onStatUpdate('free_throws_made')}
          >
            +1 PT
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-success"
            onClick={onStatUpdate('field_goals_made')}
          >
            +2 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-success"
            onClick={onStatUpdate('three_point_field_goals_made')}
          >
            +3 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={onStatUpdate('free_throws_missed')}
          >
            Miss 1 PT
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={onStatUpdate('field_goals_missed')}
          >
            Miss 2 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={onStatUpdate('three_point_field_goals_missed')}
          >
            Miss 3 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={onStatUpdate('rebounds_offensive')}
          >
            +1 REB OFF
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={onStatUpdate('steals')}
          >
            +1 STL
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={onStatUpdate('rebounds_defensive')}
          >
            +1 REB DEF
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={onStatUpdate('assists')}
          >
            +1 ASS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={onStatUpdate('blocks')}
          >
            +1 BLK
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={onStatUpdate('turnovers')}
          >
            +1 TO
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={onStatUpdate('fouls_personal')}
          >
            P. Fault
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={onStatUpdate('fouls_technical')}
          >
            T. Fault
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={onStatUpdate('fouls_flagrant')}
          >
            F. Fault
          </button>
        </div>
      </div>
    </div>
  );
}

export default StatsControls;
