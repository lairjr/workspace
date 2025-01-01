import React from 'react';

import { PlayerState, TeamType } from '../../../types';
import FormField from '../../FormField';

interface StatInputProps {
  player: PlayerState;
  statKey: string;
  pushEvent: (event: string, data: any) => void;
}

function StatInput({ player, statKey, pushEvent }) {
  const value = player.stats_values[statKey];
  return (
    <div class="field has-addons has-addons-right">
      <p class="control">
        <button class="button is-primary">-</button>
      </p>
      <p class="control">{value}</p>
      <p class="control">
        <button class="button is-primary">+</button>
      </p>
    </div>
  );
}

interface EditPlayerRowProps {
  key: string;
  player: PlayerState;
  teamType: TeamType;
  pushEvent: (event: string, data: any) => void;
}

function EditPlayerRow({ player, teamType, pushEvent }: EditPlayerRowProps) {
  const onUpdatePlayerNumber = (value: string) => {
    pushEvent('update-player-in-team', {
      ['team-type']: teamType,
      player: { ...player, number: value },
    });
  };
  const onUpdatePlayerName = (value: string) => {
    pushEvent('update-player-in-team', {
      ['team-type']: teamType,
      player: { ...player, name: value },
    });
  };
  return (
    <tr key={player.id}>
      <td>
        <FormField
          initialValue={player.number}
          onChange={onUpdatePlayerNumber}
          render={(value, onChange) => (
            <input
              className="input is-small"
              type="number"
              value={value}
              onChange={onChange}
            />
          )}
        />
      </td>
      <td>
        <FormField
          initialValue={player.name}
          onChange={onUpdatePlayerName}
          render={(value, onChange) => (
            <input
              className="input is-small"
              type="text"
              value={value}
              onChange={onChange}
            />
          )}
        />
      </td>
      <td>{player.state}</td>
      <td>
        <StatInput
          player={player}
          statKey="free_throws_made"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="field_goals_made"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="three_point_field_goals_made"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="free_throws_missed"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="field_goals_missed"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="three_point_field_goals_made"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput player={player} statKey="assists" pushEvent={pushEvent} />
      </td>
      <td>
        <StatInput player={player} statKey="blocks" pushEvent={pushEvent} />
      </td>
      <td>
        <StatInput player={player} statKey="steals" pushEvent={pushEvent} />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="rebounds_defensive"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="rebounds_offensive"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput player={player} statKey="turnovers" pushEvent={pushEvent} />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="fouls_personal"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="fouls_technical"
          pushEvent={pushEvent}
        />
      </td>
      <td>
        <StatInput
          player={player}
          statKey="fouls_flagrant"
          pushEvent={pushEvent}
        />
      </td>
    </tr>
  );
}

export default EditPlayerRow;
