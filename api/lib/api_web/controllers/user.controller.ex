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

  def create(conn, params) do
    with {:ok, %{id: id}} <- Api.create_user(params) do
      conn
      |> put_status(:created)
      |> json(%{
        id: id
      })
    end
  end

  def login(conn, params) do
    with {:ok, token} <- Api.signin_user(params) do
      conn
      |> put_status(:ok)
      |> json(%{
        token: token
      })
    end
  end
end
