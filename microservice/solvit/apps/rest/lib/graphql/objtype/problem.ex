defmodule Rest.Schema.ObjectType.Problem do
  use Absinthe.Schema.Notation

  object :problem do
    field :id, non_null(:id)
    field :no, non_null(:integer)
    field :name, non_null(:string)
    field :content, non_null(:string)
    field :exam_input, non_null(:string)
    field :exam_output, non_null(:string)
    field :test_input, non_null(:string)
    field :test_output, non_null(:string)
  end

end
