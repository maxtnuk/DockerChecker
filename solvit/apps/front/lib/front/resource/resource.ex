defmodule Front.Resource do
  alias Front.Repo
  alias Front.Resource.User

  def list_all(attr) do
    
  end

  def get_user(user)do
    Repo.all(User,user)
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
