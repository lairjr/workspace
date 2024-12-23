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
  const [showSubstituteModal, setShowSubstituteModal] = React.useState(false);
  const playingPlayers = team.players.slice(0, 5);

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
        <button
          className="button is-info is-fullwidth"
          onClick={() => setShowSubstituteModal(true)}
        >
          Substitute
        </button>
        <SubstituteModal
          team={team}
          showModal={showSubstituteModal}
          onClose={() => setShowSubstituteModal(false)}
        />
      </div>
    </div>
  );
}

export default PlayersControls;
