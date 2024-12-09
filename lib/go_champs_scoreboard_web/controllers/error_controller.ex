defmodule GoChampsScoreboardWeb.ErrorController do
  use GoChampsScoreboardWeb, :controller

  def show(conn, _params) do
    conn
    |> html(
      "<html><body><h1>Error loading scoreboard</h1><p>Something went wrong. Please try again later.</p></body></html>"
    )
  end
end
