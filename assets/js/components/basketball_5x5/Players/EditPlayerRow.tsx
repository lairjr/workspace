import React from 'react';

import { PlayerState, TeamType } from '../../../types';
import FormField from '../../FormField';

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
    </tr>
  );
}

export default EditPlayerRow;
