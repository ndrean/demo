defmodule DemoWeb.SearchLive do
  use DemoWeb, :live_view

  alias DemoWeb.Airports.List

  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign(%{
       loading: false,
       code: "",
       airports: []
     })}
  end

  def handle_event(
        "code_search",
        %{"code" => code},
        socket
      ) do
    {:noreply,
     socket
     |> assign(%{
       loading: true,
       airport_code: code,
       airports: search_by_code(code)
     })}
  end

  def search_by_code(""), do: []

  def search_by_code(code) do
    # Process.sleep(4_000)

    List.list_airports()
    |> Enum.filter(&String.starts_with?(&1.code, String.upcase(code)))
  end

  def render(assigns) do
    ~H"""
      <form  phx-submit="code_search" >
        <fieldset>
          <label for="code">
            <input type="text" name="code" value={@airport_code} readonly={@loading}
              placeholder="e.g. FRA" id="code" autofocus autocomplete="off"
              inputmode="text" list="matches"
            />
          </label>
          <input class="button-primary" type="submit" value="Search Airport">
        </fieldset>
      </form>

      <%= if @loading do %>
        <div class="loader"> Loading...</div>
      <% end %>

      <datalist id="matches">
        <%= for match <- @airports do %>
          <option value={match.airport_code} ><%= match.airport_code %></option>
        <% end %>
      </datalist>

      <!--
      readOnly={@loading}
      phx-debounce="500" list="matches"






        -->
      <p>List: <%= @airports %></p>

      <!--
      <%# unless @airports !== 2 do %>
        <h2>Search Results</h2>
        <table>
          <thead>
            <tr>
              <th>Airport Code</th>
              <th>Name</th>
            </tr>
          </thead>
          <tbody id="response-airports">
            <%= for airport <- @airports do %>
            <tr>
              <td><%= airport.code %></td>
              <td><%= airport.name %></td>
            </tr>
            <% end %>
          </tbody>
        </table>
      <%# end %>
          -->
    """
  end
end
