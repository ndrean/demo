defmodule DemoWeb.FuncComp do
  use Phoenix.Component

  def get_current_time() do
    Time.utc_now()
    |> Time.to_string()
    |> String.split(".")
    |> hd
  end

  def display_clock(assigns) do
    # now = get_current_time()

    ~H"""
      <p><%= @now %></p>
    """
  end

  def display_content(assigns) do
    assigns = assign(assigns, :content, String.upcase(assigns.content))

    ~H"""
      <p> This is the: <%= @content %> </p>
    """
  end

  def display_children(assigns) do
    assigns = assign(assigns, :content, String.upcase(assigns.content))

    ~H"""
      <p>This is the  <%= assigns.content %> </p>
      <p><%= render_slot(@inner_block) %></p>
    """
  end

  def display_timer(assigns) do
    ~H"""
    <p><%= @time %></p>
    <p>Running... <%= @seconds %></p>
    """
  end

  def display_counter(assigns) do
    ~H"""
      <h3>Current count: <%= assigns.counter %></h3>
    """
  end
end
