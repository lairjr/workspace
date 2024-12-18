import React, { useState } from "react";

export interface LiveReactBase {
        pushEvent: (event: string, payload: any) => void;
        pushEventTo: (event: string, payload: any, selector: string) => void;
        handleEvent: (event: string, callback: (payload: any) => void) => void;
      }

interface MainProps extends LiveReactBase {
    game_state; any;
}

function Main({ game_state, pushEvent }: MainProps) {
    const onStartLive = () => {
        pushEvent("start-game-live-mode", {});
    };
    const [inputValue, setInputValue] = useState("");

    return (
        <div>
            <h1>5x5 Basketball</h1>

            <h2>{game_state.away_team.name}</h2>
            <h2>{game_state.away_team.total_player_stats["points"]}</h2>

            <h2>{game_state.home_team.name}</h2>
            <h2>{game_state.home_team.total_player_stats["points"]}</h2>

            <input type="text" value={inputValue} onChange={(e) => setInputValue(e.target.value)} />

            <button className="button" onClick={onStartLive}>Start Live</button>
        </div>
    )
}

export default Main;
