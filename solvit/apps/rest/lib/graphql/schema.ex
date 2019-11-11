defmodule Front.Schema do
  use Absinthe.Schema

  import_types Front.Schema.ObjectType.{
    User,
    Test,
    Problem
  }
  query do

  end
end
