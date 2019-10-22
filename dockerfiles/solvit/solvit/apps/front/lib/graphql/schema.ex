defmodule Front.Schema do
  use Absinthe.Schema

  import_types Front.Schema.Notation

  query do
    field :all_links, :problem |>non_null() |> list_of() |> non_null()
  end
end
