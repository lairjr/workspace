import React from 'react';
import Modal from '../Modal';

interface EndLiveModalProps {
  showModal: boolean;
}

function EndLiveModal({ showModal }: EndLiveModalProps) {
  return (
    <Modal title="Game has ended" showModal={showModal} onClose={() => {}}>
      Game has ended
    </Modal>
  );
}

export default EndLiveModal;
