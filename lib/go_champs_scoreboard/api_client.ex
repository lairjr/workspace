defmodule GoChampsScoreboard.ApiClient do
  require Logger
  alias HTTPoison

  @games_path "v1/games"

  @callback get_game(String.t()) :: {:ok, any()} | {:error, any()}
  def get_game(game_id, config \\ system_config()) do
    url = Keyword.get(config, :url, "") <> @games_path <> "/" <> game_id
    http_client = Keyword.get(config, :http_client)

    Logger.info("[Get Game]: From Go Champs Api", url: url)

    url
    |> http_client.get()
    |> log()
    |> handle_response()
  end

  defp log(response) do
    Logger.info("[Get Game]: Response from Go Champs Api", response: response)
    response
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}),
    do: {:ok, Poison.decode!(body)}

  defp handle_response(_), do: {:error, "something went wrong"}

  defp system_config(), do: Application.get_env(:go_champs_scoreboard, :http_client)
end
