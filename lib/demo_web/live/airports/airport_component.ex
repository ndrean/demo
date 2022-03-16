defmodule DemoWeb.Airports.AirportComponent do
  @moduledoc """
  Since it's a component, the code below goes into the calling page,
  "demo_live.ex" here and renders "demo_live.html.heex" where the
  component is used.

  """

  use Phoenix.LiveComponent

  import DemoWeb.Airports.AirportDetails
  alias DemoWeb.Airports.List

  def render(assigns) do
    ~H"""
    <div id={@id}>
      <form phx-change="code_suggest" phx-submit="code_search" phx-target={@myself} >
        <fieldset>
          <label for="code">Airport Code
            <input type="text" name="code" value={@airport_code}
              placeholder="e.g. FRA" id="airport_code" autofocus
              autocomplete="off" list={"matches-#{@id}"}
            />
            <!-- phx-debounce="500"  -->
          </label>
          <input class="button-primary" type="submit" value="Search Airport">
        </fieldset>

        <datalist id={"matches-#{@id}"}>
          <%= for match <- @matches do %>
            <option value={match.code} ><%= match.code %></option>
          <% end %>
        </datalist>
      </form>

      <%= if @loading do %>
        <div class="loader">
          Loading...
        </div>
      <% end %>

      <!-- || @loading == true -->

      <%= unless (@airports == [] ) do %>
        <h4>Search Results for: <b>"<%= @searched_code %>"</b></h4>
        <table>
          <thead>
            <tr>
              <th>Airport Code</th>
              <th>Name</th>
            </tr>
          </thead>
          <tbody id="response-airports">
            <%= for airport <- @airports do %>
              <.display_row id={airport.id} airport={airport}/>
            <% end %>
          </tbody>
        </table>
      <% end %>
    </div>
    """
  end

  def mount(_assigns, _session, socket) do
    # if connected?(socket), do: Process.send_after(self(), :tiktok, 1000)

    socket =
      socket
      |> assign(%{
        airport_code: nil,
        airports: [],
        matches: [],
        loading: false,
        id: 1
      })

    {:ok, socket}
  end

  def handle_event("code_suggest", %{"code" => airport_code}, socket) do
    socket =
      assign(socket, %{
        loading: true,
        airport_code: airport_code,
        matches: List.search_by_code(airport_code)
      })
      |> IO.inspect()

    {:noreply, socket}
  end

  def handle_event("code_search", %{"code" => airport_code}, socket) do
    list = List.search_by_code(airport_code)
    send(self(), {:run_search, %{list: list, searched_code: airport_code}})
    :timer.sleep(1_000)

    case list do
      airports ->
        {:noreply,
         assign(socket,
           airports: airports,
           loading: false,
           searched_code: airport_code,
           airport_code: nil,
           matches: []
         )}
    end
  end
end
