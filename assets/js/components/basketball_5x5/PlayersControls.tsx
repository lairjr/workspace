import React from 'react';

import { PlayerState, TeamState, TeamType } from '../../types';
import { PlayerSelection } from './Main';

interface PlayingPlayersProps {
  players: PlayerState[];
  teamType: TeamType;
  selectPlayer: (playerSelection: PlayerSelection) => void;
  selectedPlayer?: PlayerSelection;
  onSubstituteClick: (playerId: string) => void;
}

function PlayingPlayers({
  players,
  teamType,
  selectPlayer,
  selectedPlayer,
  onSubstituteClick,
}: PlayingPlayersProps) {
  return (
    <div className="columns is-multiline">
      <div className="column is-12">
        <ul>
          {players.map((player) => (
            <li key={player.id}>
              <button
                className={`button is-fullwidth ${
                  player.id === selectedPlayer?.playerId ? 'is-dark' : ''
                }`}
                onClick={() =>
                  selectPlayer({ playerId: player.id, teamType: teamType })
                }
              >
                {player.name + ' - ' + player.number}
              </button>
            </li>
          ))}
        </ul>
      </div>
      <div className="column is-12"></div>
      <div className="column is-12">
        <button
          className="button is-info is-fullwidth"
          onClick={onSubstituteClick}
        >
          Substitute
        </button>
      </div>
    </div>
  );
}

interface BenchPlayersProps {
  players: PlayerState[];
  onPlayerClick: (playerId: string) => void;
  onCancelClick: () => void;
}

function BenchPlayers({
  players,
  onPlayerClick,
  onCancelClick,
}: BenchPlayersProps) {
  return (
    <div className="columns is-multiline">
      <div className="column is-12">
        <ul>
          {players.map((player) => (
            <li key={player.id}>
              <button
                className="button is-fullwidth"
                onClick={() => onPlayerClick(player.id)}
              >
                {player.name + ' - ' + player.number}
              </button>
            </li>
          ))}
        </ul>
      </div>
      <div className="column is-12"></div>
      <div className="column is-12">
        <button
          className="button is-danger is-fullwidth"
          onClick={onCancelClick}
        >
          Cancel
        </button>
      </div>
    </div>
  );
}

interface PlayersControlsProps {
  team: TeamState;
  pushEvent: (event: string, payload: any) => void;
  teamType: TeamType;
  selectPlayer: (playerSelection: PlayerSelection | null) => void;
  selectedPlayer: PlayerSelection;
}

function PlayersControls({
  team,
  pushEvent,
  teamType,
  selectPlayer,
  selectedPlayer,
}: PlayersControlsProps) {
  const [showPlayingPlayers, setShowPlayingPlayers] = React.useState(true);
  const playingPlayers = team.players.filter(
    (player) => player.state === 'playing',
  );
  const benchPlayers = team.players.filter(
    (player) => player.state !== 'playing',
  );
  const onSubstitute = (playerId: string) => {
    pushEvent('substitute-player', {
      ['team-type']: teamType,
      ['playing-player-id']: selectedPlayer.playerId,
      ['bench-player-id']: playerId,
    });
    setShowPlayingPlayers(true);
    selectPlayer(null);
  };

  return showPlayingPlayers ? (
    <PlayingPlayers
      players={playingPlayers}
      selectPlayer={selectPlayer}
      selectedPlayer={selectedPlayer}
      teamType={teamType}
      onSubstituteClick={() => setShowPlayingPlayers(false)}
    />
  ) : (
    <BenchPlayers
      players={benchPlayers}
      onCancelClick={() => setShowPlayingPlayers(true)}
      onPlayerClick={onSubstitute}
    />
  );
}

export default PlayersControls;
