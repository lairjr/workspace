import React, { useState } from 'react';
import { GameState, TeamType } from '../../types';
import StatsControls from './StatsControls';
import ClockControls from './ClockControls';
import TopLevel from './TopLevel';
import PlayersControls from './PlayersControls';
import TeamControls from './TeamControls';

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

  return (
    <div>
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
          <TeamControls team={game_state.home_team} teamType="home" />
        </div>

        <div className="column is-4">
          <PlayersControls
            team={game_state.away_team}
            pushEvent={pushEvent}
            teamType="away"
            selectPlayer={setPlayerSelection}
          />
        </div>

        <div className="column is-4">
          <StatsControls
            playerSelection={playerSelection}
            pushEvent={pushEvent}
          />
        </div>

        <div className="column is-4 has-text-right">
          <PlayersControls
            team={game_state.home_team}
            pushEvent={pushEvent}
            teamType="home"
            selectPlayer={setPlayerSelection}
          />
        </div>
      </div>
    </div>
  );
}

export default Main;
