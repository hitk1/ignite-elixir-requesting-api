defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias ApiWeb.FallbackController

  action_fallback(FallbackController)

  def show(conn, %{"username" => username}) do
    with {:ok, list} <- Api.request_user_repo(username) do
      conn
      |> put_status(:ok)
      |> json(list)
    end
  end
end
