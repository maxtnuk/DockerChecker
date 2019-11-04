defmodule Front.Schema.Notation do
  use Absinthe.Schema.Notation

  #problem info
  object :pro_info do
    field :info, non_null(:problem)
    field :ex, :case
  end

  object :problem do
    field :id, non_null(:id)
    field :no, non_null(:integer)
    field :name, non_null(:string)
  end

  object :coninfo do
    field :con_id, non_null(:id)
    field :stdio, non_null(:string)
  end

  #test
  object :test do
    field :ex_id, non_null(:id)
    field :pro_id, non_null(:string)
    field :ex_input, list_of(:case)
  end

  object :case do
    field :input, list_of(:coninfo)
    filed :output, list_of(:coninfo)
  end

  # user
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
