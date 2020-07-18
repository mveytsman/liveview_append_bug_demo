defmodule LiveviewAppendBugDemoWeb.PageLive do
  use LiveviewAppendBugDemoWeb, :live_view

  @impl true
  def render(assigns) do
    ~L"""
    <button phx-click="inc_counter">Increment counter</button>
    <button phx-click="add_item">Add item to list</button>
    <div id="counter"><%= @counter %></div>
    <ul id="list" phx-update="append">
    <%= for i <- @list do %>
      <li id="<%= i %>"><%= i %></li>
    <% end %>
    </ul>
    """
  end
  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:counter, 0) |> assign(:list, []) |> assign(:last_id, 0)}
  end

  @impl true
  def handle_event("inc_counter", _, socket) do
    {:noreply,
     socket |> assign(:counter, socket.assigns.counter + 1)}
  end

  def handle_event("add_item", _, socket) do
    {:noreply,
     socket |> assign(:list, [socket.assigns.last_id]) |> assign(:last_id, socket.assigns.last_id + 1)}
  end
end
