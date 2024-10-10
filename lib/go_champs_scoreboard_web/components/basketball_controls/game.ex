defmodule Components.BasketballControls.Game do
  use Phoenix.Component

  def format_time(time) when is_binary(time) do
    case Time.from_iso8601(time) do
      {:ok, time} -> format_time(time)
      {:error, _reason} -> "Invalid time"
    end
  end

  def format_time(%Time{} = time) do
    minutes = time.minute
    seconds = time.second
    "#{pad_zero(minutes)}:#{pad_zero(seconds)}"
  end

  defp pad_zero(number) when number < 10 do
    "0#{number}"
  end

  defp pad_zero(number), do: "#{number}"

  def time_controls(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12 has-text-centered">
        <button class="button">
          <%= "<" %>
        </button>

        <button class="button">
          2o
        </button>

        <button class="button">
          <%= ">" %>
        </button>
      </div>

      <div class="column is-12 has-text-centered">
        <button class="button">
          <%= "<" %>
        </button>

        <button class="button">
          <%= format_time(@game_state.clock_time) %>
        </button>

        <button class="button">
          <%= ">" %>
        </button>
      </div>

      <div class="column is-12 has-text-centered">
        <button class="button">
          Start
        </button>

        <button class="button">
          Pause
        </button>
      </div>
    </div>
    """
  end

  def home_team_totals(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <button class="button">
          Active log
        </button>

        <button class="button">
          Undo
        </button>

        <button class="button">
          T. Foul
        </button>
      </div>

      <div class="column is-12 has-text-right">
        <button class="button" phx-click="show-team-box-score" phx-value-team-type="home">
          Box score
        </button>

        <button class="button is-large" phx-click="select-team" phx-value-team-type="home">
          <%= @game_state.home_team.name %>
        </button>

        <button class="button is-large">
          <%= @game_state.home_team.score %>
        </button>
      </div>
    </div>
    """
  end

  def away_team_totals(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12"></div>

      <div class="column is-12">
        <button class="button is-large">
          <%= @game_state.away_team.score %>
        </button>

        <button class="button is-large" phx-click="select-team" phx-value-team-type="away">
          <%= @game_state.away_team.name %>
        </button>

        <button class="button" phx-click="show-team-box-score" phx-value-team-type="away">
          Box score
        </button>
      </div>
    </div>
    """
  end

  def main(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <div class="columns">
          <div class="column is-4">
            <Components.BasketballControls.Game.home_team_totals game_state={@game_state} />
          </div>

          <div class="column is-4 has-text-centered">
            <Components.BasketballControls.Game.time_controls game_state={@game_state} s />
          </div>

          <div class="column is-4">
            <Components.BasketballControls.Game.away_team_totals game_state={@game_state} />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
