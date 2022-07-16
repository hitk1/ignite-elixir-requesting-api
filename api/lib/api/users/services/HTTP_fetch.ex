defmodule Api.Users.Services.HTTPFetch do
  use Tesla

  alias Tesla.Env, as: TeslaEnv

  plug(Tesla.Middleware.JSON)
  # Lembrar de definir um user agent (mesmo que qualquer) para consumo de APIs
  plug(Tesla.Middleware.Headers, [{"user-agent", "tesla-http-client/1.4"}])

  def call(username) do
    get("https://api.github.com/users/#{username}/repos")
    |> handle_response()
  end

  defp handle_response({:ok, %TeslaEnv{status: 403}}), do: {:error, "Request forbidden"}

  defp handle_response({:ok, %TeslaEnv{status: 200, body: []}}), do: {:error, "No data found"}

  defp handle_response({:ok, %TeslaEnv{status: 200, body: body} = result}) do
    IO.inspect(result)

    body
    |> select_specific_fields()
  end

  defp select_specific_fields(list) do
    result_list =
      Enum.map(
        list,
        fn item ->
          %{
            "id" => id,
            "name" => name,
            "description" => description,
            "html_url" => html_url,
            "stargazers_count" => stargazers_count
          } = item

          %{
            "id" => id,
            "name" => name,
            "description" => description,
            "html_url" => html_url,
            "stargazers_count" => stargazers_count
          }
        end
      )

    {:ok, result_list}
  end
end
