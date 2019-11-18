defmodule Graphql.Schema.ObjectType.Result do
  use Absinthe.Schema.Notation

  object :result do
    field :container_id, :string
    field :image_name, :string
    field :message, :string
    field :status, :string
  end

  object :delete_result do
    field :container_id, :string
  end
end
