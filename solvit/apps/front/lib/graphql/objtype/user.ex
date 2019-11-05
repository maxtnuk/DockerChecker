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

  connection node_type: :user

  object :user_queries do
    connection field :list_user, node_type: :user do
      arg :name, :string
      arg :user_id, :id

      resolve fn
        args, _ ->
          pagination_limit = Application.get_env(:front, :data_pagination)[:limit]
          cond do
            Map.fetch(args, :first) == :error && Map.fetch(args, :last) == :error ->
              {:error, "The argument \"first\" or the argument \"last\" must be present"}
            Map.get(args, :first, 0) > pagination_limit || Map.get(args, :last, 0) > pagination_limit ->
              {:error, "The first/last argument must be lower or equal than #{pagination_limit}" }
            true ->
              Resolvers.Resource.User.paged_list(args)
          end
      end

      middleware &Base.replace_relay_connection_cursors/2
    end

  end

end
