defmodule Api do
  alias Api.Users.Services.HTTPFetch, as: RequestUserRepoData
  alias Api.Users.Services.Create, as: CreateUser
  alias Api.Users.Services.Signin, as: SigninUser

  defdelegate request_user_repo(username), to: RequestUserRepoData, as: :call
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate signin_user(params), to: SigninUser, as: :call
end
