defmodule RocketpayWeb.TesteController do
  use RocketpayWeb, :controller

  def index(conn, _parans) do
    text(conn, "Ola mundo!, Elixir")
  end

end
