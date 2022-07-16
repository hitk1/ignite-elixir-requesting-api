defmodule Api do
  alias Api.Users.Services.HTTPFetch, as: RequestUserRepoData

  defdelegate request_user_repo(username), to: RequestUserRepoData, as: :call
end
