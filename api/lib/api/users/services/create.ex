defmodule Api.Users.Services.Create do
  alias Api.Repo
  alias Api.Users.Model, as: UserModel

  def call(params) do
    with %{valid?: true} = changeset <- UserModel.changeset(params) do
      case Repo.insert(changeset) do
        {:ok, %Api.Users.Model{} = user} -> {:ok, user}
        error -> {:error, error}
      end
    end
  end
end
