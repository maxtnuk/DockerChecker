defmodule Graphql.Schema.ObjectType.Container do
  use Absinthe.Schema.Notation

  object :container do
    field :container_id, :string
    field :image_name, :string
    field :status, :string
  end
end
