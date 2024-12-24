import React from 'react';
import Main from './basketball_5x5/Main';
import { GameState } from '../types';

const DEFAULT_GAME_STATE = {
  id: '',
  away_team: {
    name: '',
    players: [],
    total_player_stats: {},
    stats_values: {},
  },
  home_team: {
    name: '',
    players: [],
    total_player_stats: {},
    stats_values: {},
  },
  sport_id: '',
  clock_state: {
    initial_period_time: 0,
    time: 0,
    period: 0,
    state: 'not_started',
  },
  live_state: {
    state: 'not_started',
  },
} as GameState;

const ScoreboardRegistry = {
  basketball: Main,
  default: () => <h1>Not Found</h1>,
};

interface ScoreboardProps {
  game_data: string;
  pushEvent: (event: string, payload: any) => void;
  pushEventTo: (event: string, payload: any, selector: string) => void;
  handleEvent: (event: string, callback: (payload: any) => void) => void;
}

function Scoreboard({ game_data, pushEvent }: ScoreboardProps) {
  const object = JSON.parse(game_data);
  const game_state = (object.result as GameState) || DEFAULT_GAME_STATE;
  const sportId = game_state.sport_id ? game_state.sport_id : 'default';
  const Component = ScoreboardRegistry[sportId];
  const isLoading = object.loading || false;

  return (
    <div className="container">
      {isLoading ? (
        <p>Loading...</p>
      ) : (
        <Component game_state={game_state} pushEvent={pushEvent} />
      )}
    </div>
  );
}

export default Scoreboard;
