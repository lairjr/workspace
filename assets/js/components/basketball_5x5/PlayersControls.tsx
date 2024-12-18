import React from 'react';

import { TeamState } from '../../types';
import { PlayerSelection } from './Main';

interface PlayersControlsProps {
  team: TeamState;
  pushEvent: (event: string, payload: any) => void;
  teamType: 'home' | 'away';
  selectPlayer: (playerSelection: PlayerSelection) => void;
}

function PlayersControls({
  team,
  pushEvent,
  teamType,
  selectPlayer,
}: PlayersControlsProps) {
  const playingPlayers = team.players.slice(0, 5);
  const benchPlayers = team.players.slice(5);

  return (
    <div className="columns is-multiline">
      <ul className="column is-12">
        {playingPlayers.map((player) => (
          <li key={player.id}>
            <button
              className="button is-dark is-outlined is-fullwidth"
              onClick={() =>
                selectPlayer({ playerId: player.id, teamType: teamType })
              }
            >
              {player.name + ' - ' + player.number}
            </button>
          </li>
        ))}
      </ul>

      <div className="column is-12"></div>
      <div className="column is-12">
        <button className="button is-info is-fullwidth">Substitute</button>
      </div>
      <div className="column is-12">
        <button className="button is-info is-fullwidth">Edit player</button>
      </div>
      <div className="column is-12">
        <button className="button is-info is-fullwidth">Add player</button>
      </div>
      <div className="column is-12">
        <button className="button is-info is-fullwidth">Remove player</button>
      </div>
    </div>
  );
}

export default PlayersControls;
