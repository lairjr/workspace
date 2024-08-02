defmodule GoChampsScoreboard.ApiClient do
  alias HTTPoison

  @games_path "/games"

  @callback get_game(String.t()) :: {:ok, any()} | {:error, any()}
  def get_game(game_id, config \\ system_config()) do
    url = Keyword.get(config, :url, "") <> @games_path <> "/" <> game_id
    http_client = Keyword.get(config, :http_client)

    url
    |> http_client.get()
    |> handle_response()
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}), do: {:ok, Poison.decode!(body) }
  defp handle_response(_), do: {:error, "something went wrong"}

  defp system_config(), do: Application.get_env(:go_champs_scoreboard, :http_client)
end
