import React from 'react';
import Modal from '../Modal';

interface EndLiveModalProps {
  showModal: boolean;
  pushEvent: (event: string, data: any) => void;
}

function EndLiveModal({ showModal, pushEvent }: EndLiveModalProps) {
  const onResetLiveClick = () => {
    pushEvent('reset-game-live-mode', {});
  };

  return (
    <Modal title="Game has ended" showModal={showModal} onClose={() => {}}>
      Game has ended
      <button
        className="button is-danger is-fullwidth"
        onClick={onResetLiveClick}
      >
        Reset live
      </button>
    </Modal>
  );
}

export default EndLiveModal;
