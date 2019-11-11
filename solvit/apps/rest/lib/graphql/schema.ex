defmodule Front.Schema do
  use Absinthe.Schema
  alias Rest.Resolver
  import_types Front.Schema.ObjectType
end
