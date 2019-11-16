defmodule Graphql.Schema.ObjectType.User do
  use Absinthe.Schema.Notation

  object :user do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :profile, :string
    field :problem_list, list_of(:user_problem)
  end

  object :user_problem do
    filed :pro_no, non_null(:integer)
    filed :composefile, non_null(:string)
    filed :sources, list_of(:file)
    filed :result, list_of(:result)
    field :docker_file, list_of(:user_dockerfile)
  end

  object :user_dockerfile do
    field :image_name, non_null(:string)
    field :source, non_null(:string)
  end
end
