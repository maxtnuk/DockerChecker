defmodule Graphql.Schema.ObjectType.Test do
  use Absinthe.Schema.Notation

  object :file do
    filed :file_name, non_null(:string)
    field :type, non_null(:string)
    field :source, non_null(:string)
  end
end
