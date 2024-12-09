defmodule GoChampsScoreboardWeb.ScoreboardController do
  use GoChampsScoreboardWeb, :controller

  def load(conn, %{"game_id" => game_id, "token" => token}) do
    conn
    |> put_session(:api_token, token)
    |> redirect(to: "/scoreboard/control/#{game_id}")
  end
end
