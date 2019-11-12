defmodule Rest.Schema do
  use Absinthe.Schema
  alias Rest.Resolver

  import_types Rest.Schema.ObjectType.Test
  import_types Rest.Schema.ObjectType.User
  import_types Rest.Schema.ObjectType.Problem

  query do
    field :get_pro, :problem do
      arg :id, type: non_null(:id)

      resolve fn (_args, _info) ->
        :ok
      end
    end
    field :get_user, :user do
      arg :id, type: non_null(:id)

      resolve &Resolve.user_get/1
    end
  end
end
