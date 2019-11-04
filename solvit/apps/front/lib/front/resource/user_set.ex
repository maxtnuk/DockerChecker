defmodule Front.Resource.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Front.Resource.User

  schema "user" do
    field :user_id,           :id
    field :name,              :string
    field :profile,           :map
    field :problems,          {:array, :map}
  end

  def changeset(%User{} = content, attrs) do
      content
      |> cast(attrs, [
        :user_id,:name,:profile,:problems
        ])
      |> validate_required([:id])
  end
end
