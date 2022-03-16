defmodule DemoWeb.DemoLive do
  use DemoWeb, :live_view

  import DemoWeb.FuncComp
  # import DemoWeb.Airports.AirportComponent
  # alias DemoWeb.Airports.List
  # alias DemoWeb.Airports.List

  def mount(_assigns, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tiktok, 1000)

    socket =
      socket
      |> assign(%{
        light_bulb_status: "off",
        on_button_status: "",
        off_button_status: "disabled",
        now: get_current_time(),
        counter: 0,
        seconds: 0,
        stop_timer: true,
        time: get_current_time(),
        delay: 0
      })

    {:ok, socket}
  end

  ####################################
  def handle_event("on", _value, socket) do
    {:noreply,
     assign(socket, %{
       light_bulb_status: "on",
       on_button_status: "disabled",
       off_button_status: "",
       now: get_current_time()
     })}
  end

  def handle_event("off", _value, socket) do
    {:noreply,
     assign(socket, %{
       light_bulb_status: "off",
       on_button_status: "",
       off_button_status: "disabled",
       now: get_current_time()
     })}
  end

  ###########################################
  @doc """
  The `handle_event` to the tag **"inc"** uses `update` on the socket, so needs a **function**.
  The `handle_event` to the tag **"dec"** uses `assign` on the socket,
  so we extract the counter from the **socket.assigns** and calculate the value.

  """
  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter - 1)}
  end

  def handle_event("reset", _value, socket) do
    {:noreply, assign(socket, counter: 0)}
  end

  ######################################

  #   # we send a msg so that the `search_by_code` will run in another process
  #   # will we set the timer.sleep. Otherwise, it runs sequentially so the process
  #   # sleeps, and then searches.
  #   send(self(), {:run_search, airport_code})
  #   :timer.sleep(1_000)

  #######################################################
  # The webpage sends a message to the LiveView to start the timer
  # This is done with the "phx-click" binding
  # We insert a timer: it sends an event every 1s to itself with the message ":tick".
  # We will write a handler on the message ":tick" with the method handle_info.

  def handle_event("start_timer", _value, socket) do
    :timer.send_interval(1_000, self(), :tiktok)

    socket = assign(socket, %{stop_timer: false, time: get_current_time(), seconds: 0})
    {:noreply, socket}
  end

  def handle_event("stop_timer", _value, socket) do
    # delay = get_current_time() - socket.assigns.time

    {:noreply,
     socket
     |> assign(:stop_timer, true)
     |> assign(:time, get_current_time())}
  end

  # pattern matching on the socket decomposition value of "stop_timer"
  # take the value of "socket.assigns.seconds" and increment it
  def handle_info(:tiktok, %{assigns: %{seconds: seconds, stop_timer: false}} = socket) do
    # Process.send_after(self(), :tiktok, 1000)
    {:noreply,
     socket
     |> assign(
       seconds: seconds + 1,
       time: get_current_time()
     )}
  end

  def handle_info(:tiktok, %{assigns: %{stop_timer: true}} = socket) do
    {:noreply, socket |> assign(:stop_timer, true)}
  end

  def handle_info({:run_search, %{list: found_list, searched_code: searched_code}}, socket) do
    case found_list do
      [] ->
        {
          :noreply,
          socket
          |> put_flash(:info, "no airport found for: #{searched_code}")
          |> assign(loading: false, airports: [], airport_code: nil)
        }

      _airports ->
        {:noreply,
         socket
         |> assign(
           airports: found_list,
           loading: false,
           searched_code: searched_code,
           airport_code: nil
         )}
    end
  end

  # def render(assigns) do
  #     use "demo_live.html.heex" instead
  # end
end
