defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, error) do
    IO.inspect(error)

    conn
    |> put_status(:bad_request)
    |> json(%{message: error})
  end
end
