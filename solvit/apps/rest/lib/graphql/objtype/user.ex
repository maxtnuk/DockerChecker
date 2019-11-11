defmodule Front.Schema.ObjectType.User do
  alias Front.Schema.ObjectType.Base
  alias Front.Resolvers
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema, :modern

  object :user do
    field :name, non_null(:string)
    field :user_id, non_null(:id)
    field :profile, :profile
    field :problems, list_of(:user_problem)
  end

  object :user_problem do
    filed :p_info, non_null(:problem)
    filed :run, non_null(:string)
    filed :sources, list_of(:file)
    filed :state, non_null(:string)
  end

  enum :file_type, values: [:cpp, :python, :rust]

  object :file do
    field :name, non_null(:string)
    field :type, :file_type
    field :content, non_null(:string)
  end

  object :profile do

  end

end
