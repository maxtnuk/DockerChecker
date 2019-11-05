defmodule Front.Schema.ObjectType.Problem do
  use Absinthe.Schema.Notation

  object :pro_info do
    field :info, non_null(:problem)
    field :ex, :example_case
  end

  object :problem do
    field :id, non_null(:id)
    field :no, non_null(:integer)
    field :name, non_null(:string)
  end

end
