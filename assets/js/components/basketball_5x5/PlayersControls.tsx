import React from 'react';

import { TeamState, TeamType } from '../../types';
import { PlayerSelection } from './Main';
import SubstituteModal from './SubstituteModal';

interface PlayersControlsProps {
  team: TeamState;
  pushEvent: (event: string, payload: any) => void;
  teamType: TeamType;
  selectPlayer: (playerSelection: PlayerSelection) => void;
}

function PlayersControls({
  team,
  pushEvent,
  teamType,
  selectPlayer,
}: PlayersControlsProps) {
  const [showSubstitutePlayers, setShowSubstitutePlayers] =
    React.useState(false);
  const playingPlayers = team.players.slice(0, 5);
  const benchPlayers = team.players.slice(5);
  const onSubstitute = (playerId: string) => {
    setShowSubstitutePlayers(false);
    console.log('substitute', playerId);
  };

  return (
    <div className="columns is-multiline">
      {!showSubstitutePlayers && (
        <ul className="column is-12">
          {playingPlayers.map((player) => (
            <li key={player.id}>
              <button
                className="button is-dark is-outlined is-fullwidth test-class"
                onClick={() =>
                  selectPlayer({ playerId: player.id, teamType: teamType })
                }
              >
                {player.name + ' - ' + player.number}
              </button>
            </li>
          ))}
        </ul>
      )}

      {showSubstitutePlayers && (
        <ul className="column is-12">
          {benchPlayers.map((player) => (
            <li key={player.id}>
              <button
                className="button is-dark is-outlined is-fullwidth test-class"
                onClick={() => onSubstitute(player.id)}
              >
                {player.name + ' - ' + player.number}
              </button>
            </li>
          ))}
        </ul>
      )}

      <div className="column is-12"></div>
      <div className="column is-12">
        <button
          className="button is-info is-fullwidth"
          onClick={() => setShowSubstitutePlayers(true)}
        >
          Substitute
        </button>
      </div>
    </div>
  );
}

export default PlayersControls;
