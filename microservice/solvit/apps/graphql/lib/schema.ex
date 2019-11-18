defmodule Graphql.Schema do
  use Absinthe.Schema
  alias Solvit.Resolver

  import_types Graphql.Schema.ObjectType.Test
  import_types Graphql.Schema.ObjectType.User
  import_types Graphql.Schema.ObjectType.Problem
  import_types Graphql.Schema.ObjectType.Result
  import_types Graphql.Schema.ObjectType.Container

  query do

    field :run_problem, list_of(:result) do
      arg :problem, type: :integer
      arg :email, type: :string

      resolve &Resolver.run_problem/2
    end

    field :list_container, list_of(:container) do
      arg :email, type: :string

      resolve &Resolver.list_container/2
    end

    field :remove_container, list_of(:delete_result) do
      arg :id, type: :string

      resolve &Resolver.remove_container/2
    end
  end

  mutation do
    field :create_user_problem, :user_problem do
      arg :name, :string
      arg :contact, non_null(:contact)

      resolve &User.create/2
    end
  end

  input_object :contact do
    field :email, :string
  end
end
