defmodule Docker.Base do
  alias Docker.{
    Client,
    NodeConfig
  }

  def base(%NodeConfig{} = node_config,endpoint,action,options,fun) do
    options = options |> Keyword.merge(NodeConfig.get_options(node_config))
    IO.puts(Client.build_endpoint(endpoint,action)
      |> Client.build_uri(node_config))
    response =
      Client.build_endpoint(endpoint,action)
      |> Client.build_uri(node_config)
      |> Client.get!([],options)

    fun.(response)
  end
end
