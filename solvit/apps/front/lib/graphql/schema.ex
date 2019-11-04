defmodule Front.Schema do
  use Absinthe.Schema

  import_types Front.Schema.Notation
  query do

    @desc "Get all prlblems"
    field :all_problems, list_of(:pro_info) do
      resolve &Front.Resource.list_all/1
    end

    field :user, :user do
      arg :id, non_null(:id)
      resolve &Front.Resource.get_user/1
    end
  end
end
