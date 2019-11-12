defmodule Rest.Schema.ObjectType.User do
  use Absinthe.Schema.Notation

  object :user do
    field(:name, non_null(:string))
    field(:user_id, non_null(:id))
    field(:user_problem, list_of(:user_problem))
  end

  object :user_problem do
    filed(:p_info, non_null(:problem))
    filed(:run, non_null(:string))
    filed(:sources, list_of(:file))
    filed(:status, non_null(:string))
  end
end
