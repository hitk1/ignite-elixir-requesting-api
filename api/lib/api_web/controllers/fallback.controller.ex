defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, error) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: "Unexpected error"})
  end
end
