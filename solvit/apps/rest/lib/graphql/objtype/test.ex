defmodule Front.Schema.ObjectType.Test do
  use Absinthe.Schema.Notation

  object :test do
    field :user_id, non_null(:id)
    filed :pro_id, non_null(:id)
    field :source, list_of(:file)
  end

  object :file do
    field :type, non_null(:string)
    field :source, non_null(:string)
  end
end
