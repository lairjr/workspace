import React from 'react';
import { PlayerSelection } from './Main';
import debounce from '../../debounce';

interface StatsControlsProps {
  pushEvent: (event: string, payload: any) => void;
  playerSelection: PlayerSelection;
}

function StatsControls({ pushEvent, playerSelection }: StatsControlsProps) {
  const onStatUpdate = debounce<(stat: string) => void>((stat) => {
    pushEvent('update-player-stat', {
      ['stat-id']: stat,
      operation: 'increment',
      ['player-id']: playerSelection.playerId,
      ['team-type']: playerSelection.teamType,
    });
  }, 100);
  const buttonsDisabled = playerSelection === null;
  return (
    <div className="controls">
      <div className="columns is-multiline">
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-success"
            onClick={() => onStatUpdate('free_throws_made')}
            disabled={buttonsDisabled}
          >
            +1 PT
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-success"
            onClick={() => onStatUpdate('field_goals_made')}
            disabled={buttonsDisabled}
          >
            +2 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-success"
            onClick={() => onStatUpdate('three_point_field_goals_made')}
            disabled={buttonsDisabled}
          >
            +3 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={() => onStatUpdate('free_throws_missed')}
            disabled={buttonsDisabled}
          >
            Miss 1 PT
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={() => onStatUpdate('field_goals_missed')}
            disabled={buttonsDisabled}
          >
            Miss 2 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={() => onStatUpdate('three_point_field_goals_missed')}
            disabled={buttonsDisabled}
          >
            Miss 3 PTS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={() => onStatUpdate('rebounds_offensive')}
            disabled={buttonsDisabled}
          >
            +1 REB OFF
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={() => onStatUpdate('steals')}
            disabled={buttonsDisabled}
          >
            +1 STL
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={() => onStatUpdate('rebounds_defensive')}
            disabled={buttonsDisabled}
          >
            +1 REB DEF
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={() => onStatUpdate('assists')}
            disabled={buttonsDisabled}
          >
            +1 ASS
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-info"
            onClick={() => onStatUpdate('blocks')}
            disabled={buttonsDisabled}
          >
            +1 BLK
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-danger"
            onClick={() => onStatUpdate('turnovers')}
            disabled={buttonsDisabled}
          >
            +1 TO
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-warning"
            onClick={() => onStatUpdate('fouls_personal')}
            disabled={buttonsDisabled}
          >
            Personal Fault
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-warning"
            onClick={() => onStatUpdate('fouls_technical')}
            disabled={buttonsDisabled}
          >
            Technical Fault
          </button>
        </div>
        <div className="column is-4 has-text-centered">
          <button
            className="button is-tall is-warning"
            onClick={() => onStatUpdate('fouls_flagrant')}
            disabled={buttonsDisabled}
          >
            Flagrant Fault
          </button>
        </div>
      </div>
    </div>
  );
}

export default StatsControls;
