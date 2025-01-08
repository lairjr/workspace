import React from 'react';
import { GameState, DEFAULT_GAME_STATE } from '../types';
import FallingBasketball from '../icons/FallingBasketball';

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
    setCurrentScore(score);
  }, [score]);

  React.useEffect(() => {
    setScoreMakeEffect(true);
    const timeoutScoreMake = setTimeout(() => {
      setScoreMakeEffect(false);
      setScoreDiff(1);
    }, 1800);
    return () => {
      clearTimeout(timeoutScoreMake);
    };
  }, [score]);

  return (
    <div className="animated-score">
      <span
        className={`score-effect ${
          scoreMadeEffect ? `show-${scoreDiff}` : 'hide'
        }`}
      >
        <FallingBasketball />
      </span>
      <span className="title is-1">{currentScore}</span>
    </div>
  );
}

function StreamViews({ game_data }: StreamViewsProps) {
  const object = JSON.parse(game_data);
  const game_state = (object.result as GameState) || DEFAULT_GAME_STATE;
  return (
    <div className="stream-views">
      <div className="container">
        <div className="columns is-multiline">
          <div className="column is-12 has-text-centered ad">
            <span className="title is-7">go-champs.com</span>
          </div>
          <div className="column is-6 has-text-centered away">
            <span className="title is-6">{game_state.away_team.name}</span>
          </div>
          <div className="column is-6 has-text-centered home">
            <span className="title is-6">{game_state.home_team.name}</span>
          </div>
          <div className="column is-6 has-text-centered away">
            <AnimatedScore
              score={game_state.away_team.total_player_stats['points'] || 0}
            />
          </div>
          <div className="column is-6 has-text-centered home">
            <AnimatedScore
              score={game_state.home_team.total_player_stats['points'] || 0}
            />
          </div>
          <div className="column is-6 has-text-centered away">
            <span className="title is-5">
              Faltas: {game_state.away_team.total_player_stats['fouls'] || 0}
            </span>
          </div>
          <div className="column is-6 has-text-centered home">
            <span className="title is-5">
              Faltas: {game_state.home_team.total_player_stats['fouls'] || 0}
            </span>
          </div>
          <div className="column is-12 has-text-centered period">
            <span className="title is-6">
              Quarto: {game_state.clock_state.period}
            </span>
          </div>
          <div className="column is-12 has-text-centered time">
            <span className="title is-4">
              {formatTime(game_state.clock_state.time)}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default StreamViews;
