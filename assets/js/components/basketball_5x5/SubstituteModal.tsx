import React from 'react';

import { TeamState, TeamType } from '../../types';
import { PlayerSelection } from './Main';
import Modal from '../Modal';

interface SubstituteModalProps {
  team: TeamState;
  showModal: boolean;
  onClose: () => void;
}

function SubstituteModal({ team, showModal, onClose }: SubstituteModalProps) {
  const benchPlayers = team.players.slice(5);

  return (
    <Modal title="Substitute" onClose={onClose} showModal={showModal}>
      <div className="columns is-multiline">
        <ul className="column is-12">
          {benchPlayers.map((player) => (
            <li key={player.id}>
              <button className="button is-dark is-outlined is-fullwidth">
                {player.name + ' - ' + player.number}
              </button>
            </li>
          ))}
        </ul>
      </div>
    </Modal>
  );
}

export default SubstituteModal;
