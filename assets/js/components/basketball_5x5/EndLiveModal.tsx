import React from 'react';
import Modal from '../Modal';

interface EndLiveModalProps {
  showModal: boolean;
}

function EndLiveModal({ showModal }: EndLiveModalProps) {
  return (
    <Modal title="Game has ended" showModal={showModal} onClose={() => {}}>
      Game stats are saved in Go Champs and we cannot use Scoreboard anymore.
    </Modal>
  );
}

export default EndLiveModal;
