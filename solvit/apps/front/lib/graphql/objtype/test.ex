defmodule Front.Schema.ObjectType.Test do
  use Absinthe.Schema.Notation

  object :test_form do
    field :ex_id, non_null(:id)
    field :pro_id, non_null(:string)
    field :ex_input, list_of(:example_case)
  end

  object :example_case do
    field :input, list_of(:coninfo)
    filed :output, list_of(:coninfo)
  end

  object :coninfo do
    field :con_id, non_null(:id)
    field :stdio, non_null(:string)
  end

end
