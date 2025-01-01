import React from 'react';

import { GameState } from '../../types';
import Modal from '../Modal';
import BoxScore from './BoxScore';
import EditPlayersModal from './Players/EditPlayersModal';

interface TopLevelProps {
  game_state: GameState;
  pushEvent: (event: string, payload: any) => void;
}

function TopLevel({ game_state, pushEvent }: TopLevelProps) {
  const [showBoxScoreModal, setShowBoxScoreModal] = React.useState(false);
  const [showEditPlayersModal, setShowEditPlayersModal] = React.useState(false);
  const onStartLive = () => {
    pushEvent('start-game-live-mode', {});
  };
  const onEndLive = () => {
    pushEvent('end-game-live-mode', {});
  };

  return (
    <nav className="level">
      <div className="level-left">
        <p className="level-item">
          <button
            className="button is-info"
            onClick={() => setShowBoxScoreModal(true)}
          >
            Box score
          </button>

          <button
            className="button is-info"
            onClick={() => setShowEditPlayersModal(true)}
          >
            Edit players
          </button>
        </p>
        <Modal
          title="Box Score"
          onClose={() => setShowBoxScoreModal(false)}
          showModal={showBoxScoreModal}
        >
          <BoxScore game_state={game_state} />
        </Modal>
        <EditPlayersModal
          game_state={game_state}
          showModal={showEditPlayersModal}
          onCloseModal={() => setShowEditPlayersModal(false)}
          pushEvent={pushEvent}
        />
      </div>

      <div className="level-right">
        <p className="level-item">
          {game_state.live_state.state === 'in_progress' ? (
            <button className="button is-danger" onClick={onEndLive}>
              End Live
            </button>
          ) : (
            <button className="button is-success" onClick={onStartLive}>
              Start Live
            </button>
          )}
        </p>
      </div>
    </nav>
  );
}

export default TopLevel;
function useState(arg0: boolean): [any, any] {
  throw new Error('Function not implemented.');
}
