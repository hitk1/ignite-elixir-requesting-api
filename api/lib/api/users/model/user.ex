defmodule Api.Users.Model do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field(:password, :string)
    field(:password_raw, :string, virtual: true)

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:password_raw])
    |> put_password
  end

  defp put_password(
         %Ecto.Changeset{valid?: true, changes: %{password_raw: password_raw}} = changeset
       ) do
    change(
      changeset,
      Pbkdf2.add_hash(password_raw, hash_key: :password)
    )
  end
end
