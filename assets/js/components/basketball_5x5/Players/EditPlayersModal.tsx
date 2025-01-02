import React from 'react';

import { GameState, TeamType } from '../../../types';
import Modal from '../../Modal';
import EditPlayerRow from './EditPlayerRow';
import AddPlayerRow from './AddPlayerRow';

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
  const [showAddPlayerRow, setShowAddPlayerRow] = React.useState(false);
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
          <button className="button" onClick={() => setShowAddPlayerRow(true)}>
            Add player
          </button>
        </div>

        <div className="column is-12">
          <div className="table-container">
            <table className="table is-fullwidth">
              <thead>
                <tr>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>#</th>
                  <th style={{ minWidth: '140px', maxWidth: '140px' }}>Name</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>+ 1 PT</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>
                    + 2 PTs
                  </th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>
                    + 3 PTs
                  </th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>
                    1 PT Miss
                  </th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>
                    2 PTs Miss
                  </th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>
                    3 PTs Miss
                  </th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>AST</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>BLK</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>STL</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>DRB</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>ORB</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>TO</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>PF</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>TF</th>
                  <th style={{ minWidth: '65px', maxWidth: '65px' }}>FF</th>
                  <th style={{ minWidth: '85px', maxWidth: '85px' }}>Delete</th>
                </tr>
              </thead>
              <tbody>
                {showAddPlayerRow && (
                  <AddPlayerRow
                    teamType={activeTab}
                    pushEvent={pushEvent}
                    onConfirmAction={() => setShowAddPlayerRow(false)}
                  />
                )}
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
      </div>
    </Modal>
  );
}

export default EditPlayersModal;
