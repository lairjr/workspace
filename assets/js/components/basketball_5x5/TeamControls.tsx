import React from 'react';

import { TeamState, TeamType } from '../../types';

interface TeamControlsProps {
  team: TeamState;
  teamType: TeamType;
}

function TeamControls({ team, teamType }: TeamControlsProps) {
  const reverseClass =
    teamType === 'home' ? 'is-flex-direction-row-reverse' : '';
  const teamNameClass = teamType === 'home' ? 'is-justify-content-right' : '';
  return (
    <div className="controls">
      <div className={`columns is-multiline ${reverseClass}`}>
        <div
          className={`column is-9 is-flex is-align-items-center ${teamNameClass}`}
        >
          <p className="title is-4">{team.name}</p>
        </div>
        <div className="column is-3">
          <p className="chip-label title is-4">
            {team.total_player_stats['points'] || 0}
          </p>
        </div>
      </div>
    </div>
  );
}

export default TeamControls;
