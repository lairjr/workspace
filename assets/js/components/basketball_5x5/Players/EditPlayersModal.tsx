import React from 'react';

import { GameState, TeamType } from '../../../types';
import Modal from '../../Modal';
import EditPlayerRow from './EditPlayerRow';

interface EditPlayersModalProps {
  game_state: GameState;
  showModal: boolean;
  onCloseModal: () => void;
  pushEvent: (event: string, data: any) => void;
}

function EditPlayersModal({
  game_state,
  showModal,
  onCloseModal,
  pushEvent,
}: EditPlayersModalProps) {
  const [activeTab, setActiveTab] = React.useState('away' as TeamType);
  const selectedTeam =
    activeTab === 'away' ? game_state.away_team : game_state.home_team;
  return (
    <Modal
      title="Edit Players"
      showModal={showModal}
      onClose={onCloseModal}
      modalCardStyle={{ width: '1024px' }}
    >
      <div className="tabs is-boxed">
        <ul>
          <li className={activeTab === 'away' ? 'is-active' : ''}>
            <a onClick={() => setActiveTab('away')}>
              <span>{game_state.away_team.name}</span>
            </a>
          </li>
          <li className={activeTab === 'home' ? 'is-active' : ''}>
            <a onClick={() => setActiveTab('home')}>
              <span>{game_state.home_team.name}</span>
            </a>
          </li>
        </ul>
      </div>

      <div className="columns is-multiline">
        <div className="column is-12">
          <button className="button">Add player</button>
          <button className="button">Remove player</button>
        </div>

        <div className="column is-12">
          <table className="table is-fullwidth">
            <thead>
              <tr>
                <th>Number</th>
                <th>Name</th>
                <th>State</th>
                <th>+ 1 PT</th>
                <th>+ 2 PTs</th>
                <th>+ 3 PTs</th>
                <th>1 PT Miss</th>
                <th>2 PTs Miss</th>
                <th>3 PTs Miss</th>
                <th>AST</th>
                <th>BLK</th>
                <th>STL</th>
                <th>DRB</th>
                <th>ORB</th>
                <th>TO</th>
                <th>PF</th>
                <th>TF</th>
                <th>FF</th>
              </tr>
            </thead>
            <tbody>
              {selectedTeam.players.map((player) => (
                <EditPlayerRow
                  key={player.id}
                  player={player}
                  teamType={activeTab}
                  pushEvent={pushEvent}
                />
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </Modal>
  );
}

export default EditPlayersModal;
