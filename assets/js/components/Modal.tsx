import React from 'react';

interface ModalProps {
  title: string;
  onClose: () => void;
  showModal: boolean;
  children?: React.ReactNode;
  modalCardStyle?: React.CSSProperties;
}

function Modal({
  title,
  onClose,
  children,
  showModal,
  modalCardStyle,
}: ModalProps) {
  return (
    <div className={`modal ${showModal ? 'is-active' : ''}`}>
      <div className="modal-background" onClick={onClose} />
      <div className="modal-card" style={modalCardStyle}>
        <header className="modal-card-head">
          <p className="modal-card-title">{title}</p>
          <button className="delete" aria-label="close" onClick={onClose} />
        </header>
        <section className="modal-card-body">{children}</section>
      </div>
    </div>
  );
}

export default Modal;
