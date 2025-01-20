import React from 'react';
import { GameState, DEFAULT_GAME_STATE } from '../types';

interface StreamViewsProps {
  game_data: string;
}

function formatTime(time: number) {
  const minutes = Math.floor(time / 60);
  const seconds = time % 60;
  const minutesStr = minutes < 10 ? `0${minutes}` : minutes;
  const secondsStr = seconds < 10 ? `0${seconds}` : seconds;
  return `${minutesStr}:${secondsStr}`;
}

function AnimatedScore({ score }: { score: number }) {
  const [currentScore, setCurrentScore] = React.useState(0);
  const [scoreMadeEffect, setScoreMakeEffect] = React.useState(false);
  const [scoreDiff, setScoreDiff] = React.useState(1);

  React.useEffect(() => {
    setScoreDiff(score - currentScore);
  }, [score]);

  React.useEffect(() => {
    setScoreMakeEffect(true);
    const timeoutScore = setTimeout(() => {
      setCurrentScore(score);
    }, 600);
    const timeoutScoreMake = setTimeout(() => {
      setScoreMakeEffect(false);
      setScoreDiff(1);
    }, 2000);
    return () => {
      clearTimeout(timeoutScoreMake);
      clearTimeout(timeoutScore);
    };
  }, [score]);

  return (
    <div className="animated-score">
      <span className={`score-effect ${scoreMadeEffect ? `show` : 'hide'}`}>
        {scoreDiff > 0 ? `+${scoreDiff}` : ''}
      </span>
      <span className="score">{currentScore}</span>
    </div>
  );
}

function TeamScore({ teamName, score }: { teamName: string; score: number }) {
  return (
    <div className="team-score">
      <div className="name">{teamName}</div>
      <div className="score">
        <AnimatedScore score={score} />
      </div>
    </div>
  );
}

function StreamViews({ game_data }: StreamViewsProps) {
  const object = JSON.parse(game_data);
  const game_state = (object.result as GameState) || DEFAULT_GAME_STATE;
  return (
    <div className="stream-views">
      <div className="container">
        <div className="columns is-multiline is-vcentered">
          <div className="column has-text-centered away">
            <TeamScore
              teamName={game_state.away_team.name}
              score={game_state.away_team.total_player_stats['points'] || 0}
            />
          </div>
          <div className="column has-text-centered home">
            <TeamScore
              teamName={game_state.home_team.name}
              score={game_state.home_team.total_player_stats['points'] || 0}
            />
          </div>
          <div className="column is-3 has-text-centered period">
            <div className="period-time">
              <span className="period">
                {`${game_state.clock_state.period}º`}
              </span>
              <span className="time">
                {formatTime(game_state.clock_state.time)}
              </span>
            </div>
            <div className="ad">
              <span>go-champs.com</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default StreamViews;
