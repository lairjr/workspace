import React, { useState } from 'react';
import { GameState, TeamType } from '../../types';
import StatsControls from './StatsControls';
import ClockControls from './ClockControls';
import TopLevel from './TopLevel';
import PlayersControls from './PlayersControls';
import TeamControls from './TeamControls';
import EndLiveModal from './EndLiveModal';

export interface LiveReactBase {
  pushEvent: (event: string, payload: any) => void;
  pushEventTo: (event: string, payload: any, selector: string) => void;
  handleEvent: (event: string, callback: (payload: any) => void) => void;
}

export interface PlayerSelection {
  playerId: string;
  teamType: TeamType;
}

interface MainProps extends LiveReactBase {
  game_state: GameState;
}

function Main({ game_state, pushEvent }: MainProps) {
  const [playerSelection, setPlayerSelection] = useState<PlayerSelection>(null);
  const showEndLiveModal = game_state.live_state.state === 'ended';

  return (
    <>
      <TopLevel game_state={game_state} pushEvent={pushEvent} />

      <div className="columns is-multiline">
        <div className="column is-4">
          <TeamControls team={game_state.away_team} teamType="away" />
        </div>

        <div className="column is-4">
          <ClockControls
            clock_state={game_state.clock_state}
            pushEvent={pushEvent}
          />
        </div>

        <div className="column is-4">
          <div className="panel">
            <TeamControls team={game_state.home_team} teamType="home" />
          </div>
        </div>

        <div className="column is-4">
          <PlayersControls
            team={game_state.away_team}
            pushEvent={pushEvent}
            teamType="away"
            selectPlayer={setPlayerSelection}
            selectedPlayer={playerSelection}
          />
        </div>

        <div className="column is-4">
          <StatsControls
            playerSelection={playerSelection}
            pushEvent={pushEvent}
          />
        </div>

        <div className="column is-4">
          <PlayersControls
            team={game_state.home_team}
            pushEvent={pushEvent}
            teamType="home"
            selectPlayer={setPlayerSelection}
            selectedPlayer={playerSelection}
          />
        </div>

        <EndLiveModal showModal={showEndLiveModal} />
      </div>
    </>
  );
}

export default Main;
