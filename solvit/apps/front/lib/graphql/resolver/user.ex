defmodule Front.Resolvers.Resource.User do
  alias Front.Resource
  alias Absinthe.Relay
  alias Front.Helpers.Absinthe.DataPaginator
  def paged_list(args) do
      pagination_args = DataPaginator.build_args(args)
      contents = Resources.list_all(pagination_args)
      {contents, page_info} = DataPaginator.page_info(contents, pagination_args)
      Relay.Connection.from_slice(contents, pagination_args.offset, page_info)
  end
end
