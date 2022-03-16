defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  @moduledoc """
  This page displays to function component and a navigation.
  """
  def render(assigns) do
    ~H"""
      <h1>A simple function component:</h1>
     <DemoWeb.FuncComp.display_content content="first"/>
     <h1>A function component with an "inner slot"</h1>
     <DemoWeb.FuncComp.display_children content="second">
      <span>A children as an inner block</span>
     </DemoWeb.FuncComp.display_children>



      <h1>Visit <a data-phx-redirect="redirect" href="http://localhost:4000/demo">Go!</a></h1>
    """
  end
end
