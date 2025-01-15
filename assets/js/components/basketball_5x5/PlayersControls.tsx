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

function renderPlayerButtonText(player: PlayerState) {
  if (!player.number) {
    return `${player.name}`;
  }

  return `${player.number} - ${player.name}`;
}

function PlayingPlayers({
  players,
  teamType,
  selectPlayer,
  selectedPlayer,
  onSubstituteClick,
}: PlayingPlayersProps) {
  return (
    <div className="controls">
      <div className="columns is-multiline">
        {players.map((player) => (
          <div key={player.id} className="column is-12">
            <button
              className={`button is-fullwidth ${
                player.id === selectedPlayer?.playerId ? 'is-dark' : ''
              }`}
              onClick={() =>
                selectPlayer({ playerId: player.id, teamType: teamType })
              }
            >
              {renderPlayerButtonText(player)}
            </button>
          </div>
        ))}
        <div className="column is-12"></div>
        <div className="column is-12">
          <button
            className="button is-warning is-fullwidth"
            onClick={onSubstituteClick}
          >
            Substitute
          </button>
        </div>
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
    <div className="controls">
      <div className="columns is-multiline">
        {players.map((player) => (
          <div key={player.id} className="column is-12">
            <button
              className="button is-fullwidth"
              onClick={() => onPlayerClick(player.id)}
            >
              {renderPlayerButtonText(player)}
            </button>
          </div>
        ))}
        <div className="column is-12"></div>
        <div className="column is-12">
          <button
            className="button is-warning is-fullwidth"
            onClick={onCancelClick}
          >
            Cancel
          </button>
        </div>
      </div>
    </div>
  );
}

interface NotStartingPlayersProps {
  players: PlayerState[];
  teamType: TeamType;
  onPlayerClick: (playerSelection: PlayerSelection) => void;
}

function NotStartingPlayers({
  players,
  teamType,
  onPlayerClick,
}: NotStartingPlayersProps) {
  return (
    <div className="controls">
      <div className="columns is-multiline">
        <div className="column is-12 has-text-centered">
          <span className="title is-3">CLICK TO SELECT THE STARTING PLAYERS</span>
        </div>
        {players.map((player) => (
          <div key={player.id} className="column is-12">
            <button
              className="button is-fullwidth"
              onClick={() =>
                onPlayerClick({ playerId: player.id, teamType: teamType })
              }
            >
              {renderPlayerButtonText(player)}
            </button>
          </div>
        ))}
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

type PlayerView = 'playing' | 'bench' | 'not_started';

function PlayersControls({
  team,
  pushEvent,
  teamType,
  selectPlayer,
  selectedPlayer,
}: PlayersControlsProps) {
  const playingPlayers = team.players.filter(
    (player) => player.state === 'playing',
  );
  const benchPlayers = team.players.filter(
    (player) => player.state !== 'playing',
  );
  const initialView = playingPlayers.length < 5 ? 'not_started' : 'playing';
  const [playerView, setPlayerView] = React.useState<PlayerView>(initialView);
  React.useEffect(() => {
    setPlayerView(initialView);
  }, [initialView]);
  const onSubstitute = (playerId: string) => {
    pushEvent('substitute-player', {
      ['team-type']: teamType,
      ['playing-player-id']: selectedPlayer.playerId,
      ['bench-player-id']: playerId,
    });
    setPlayerView('playing');
    selectPlayer(null);
  };
  const onPlayerStartUp = (selectPlayer: PlayerSelection) => {
    pushEvent('substitute-player', {
      ['team-type']: selectPlayer.teamType,
      ['playing-player-id']: null,
      ['bench-player-id']: selectPlayer.playerId,
    });
  };

  return (
    <>
      {playerView === 'playing' && (
        <PlayingPlayers
          players={playingPlayers}
          selectPlayer={selectPlayer}
          selectedPlayer={selectedPlayer}
          teamType={teamType}
          onSubstituteClick={() => setPlayerView('bench')}
        />
      )}
      {playerView === 'bench' && (
        <BenchPlayers
          players={benchPlayers}
          onCancelClick={() => setPlayerView('playing')}
          onPlayerClick={onSubstitute}
        />
      )}
      {playerView === 'not_started' && (
        <NotStartingPlayers
          teamType={teamType}
          players={benchPlayers}
          onPlayerClick={onPlayerStartUp}
        />
      )}
    </>
  );
}

export default PlayersControls;
