import React from 'react';
import { GameState } from '../../types';

interface BoxScoreProps {
  game_state: GameState;
}

function BoxScore({ game_state }: BoxScoreProps) {
  const [teamType, setTeamType] = React.useState('home');
  const team =
    teamType === 'home' ? game_state.home_team : game_state.away_team;

  return (
    <div className="columns is-multiline">
      <div className="column is-12">
        <button
          className={`button is-info ${
            teamType !== 'home' ? 'is-outlined' : ''
          }`}
          onClick={() => setTeamType('home')}
        >
          {game_state.home_team.name}
        </button>

        <button
          className={`button is-info ${
            teamType !== 'away' ? 'is-outlined' : ''
          }`}
          onClick={() => setTeamType('away')}
        >
          {game_state.away_team.name}
        </button>
      </div>

      <div className="column is-12">
        <table className="table is-fullwidth">
          <thead>
            <tr>
              <th>Player</th>
              <th>PTS</th>
              <th>AST</th>
              <th>REB</th>
              <th>STL</th>
              <th>BLK</th>
              <th>TO</th>
            </tr>
          </thead>
          <tbody>
            {team.players.map((player) => (
              <tr key={player.id}>
                <td>{player.name}</td>
                <td>{player.stats_values['points']}</td>
                <td>{player.stats_values['assists']}</td>
                <td>{player.stats_values['rebounds']}</td>
                <td>{player.stats_values['steals']}</td>
                <td>{player.stats_values['blocks']}</td>
                <td>{player.stats_values['turnovers']}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default BoxScore;
