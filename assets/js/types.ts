export interface PlayerState {
  id: string;
  name: string;
  number: number;
  stats_values: { [key: string]: number };
}

export interface TeamState {
  name: string;
  players: PlayerState[];
  total_player_stats: { [key: string]: number };
  stats_values: { [key: string]: number };
}

export interface GameClockState {
  initial_period_time: number;
  time: number;
  period: number;
  state: 'not_started' | 'running' | 'paused' | 'stopped';
}

export interface LiveState {
  state: 'not_started' | 'running' | 'ended';
}

export interface GameState {
  id: string;
  away_team: TeamState;
  home_team: TeamState;
  sport_id: string;
  clock_state: GameClockState;
  live_state: LiveState;
}

export type TeamType = 'home' | 'away';
