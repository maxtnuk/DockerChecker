defmodule Front.Resource do
  alias Front.Repo
  alias Front.Resource.User

  def user_list(attr) do
    Repo.all(User,attr)
  end

  def create_user(attrs\\ %{}) do
    changeset = User.changeset(%User{}, attrs)
    case changeset.valid? do
      true ->
        Repo.insert(changeset)
      false ->
        {:error, changeset}
    end
  end
end
