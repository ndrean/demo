defmodule DemoWeb.Airports.AirportDetails do
  # use DemoWeb, :live_component
  use Phoenix.Component

  @moduledoc """
  This is a function component that renders a row in the table containing the details of an airport
  """

  @doc """
  ## Usage
    If `airport` is the enumerator of a list of airports structs, then we can do:
    ```elixir
    <DemoWeb.Airports.AirportDetails.display
      id={Integer.to_string(airport.id)}
      airport={airport
    />
    ```
  """

  def display_row(assigns) do
    assigns = assign(assigns, %{id: Integer.to_string(assigns.id), airport: assigns.airport})

    ~H"""
      <tr id={@id}>
        <td><%= @airport.code %></td>
        <td><%= assigns.airport.name %></td>
      </tr>
    """
  end
end
