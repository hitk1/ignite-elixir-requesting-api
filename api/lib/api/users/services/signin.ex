defmodule Api.Users.Services.Signin do
  use Guardian, otp_app: :api

  alias Api.Users.Model, as: UserModel
  alias Api.Repo

  def subject_for_token(%UserModel{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => _id}) do
    {:error, "not implemented"}
  end

  def call(%{"id" => id, "password_raw" => password_raw}) do
    with %Api.Users.Model{password: password_hash} = user <- Repo.get(UserModel, id),
         true <- Pbkdf2.verify_pass(password_raw, password_hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, "Not authenticated"}
      _error -> {:error, "error during authentication"}
    end
  end
end
