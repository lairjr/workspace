import React from 'react';

import { TeamState, TeamType } from '../../types';

interface TeamControlsProps {
  team: TeamState;
  teamType: TeamType;
}

function TeamControls({ team, teamType }: TeamControlsProps) {
  const reverseClass =
    teamType === 'home' ? 'is-flex-direction-row-reverse' : '';
  return (
    <div className={`columns is-multiline ${reverseClass}`}>
      <div className="column is-10">{team.name}</div>
      <div className="column is-2">
        <p>{team.total_player_stats['points']}</p>
      </div>
    </div>
  );
}

export default TeamControls;
