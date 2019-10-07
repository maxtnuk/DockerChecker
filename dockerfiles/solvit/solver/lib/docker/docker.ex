defmodule Docker.Base do
  alias Docker.{
    Client,
    NodeConfig
  }

  def base_get(%NodeConfig{} = node_config,endpoint,action,options,fun) do
    options = options
          |> Keyword.to_list()
          |> Keyword.merge(NodeConfig.get_options(node_config))
    #IO.puts(Client.build_endpoint(endpoint,action)|> Client.build_uri(node_config))
    response =
      Client.build_endpoint(endpoint,action)
      |> Client.build_uri(node_config)
      |> Client.get!([],options)

    fun.(response)
  end
  def base_post(%NodeConfig{} = node_config,endpoint,action,body,options,fun) do
    options = options
          |> Keyword.to_list()
          |> Keyword.merge(NodeConfig.get_options(node_config))
    #IO.puts(Client.build_endpoint(endpoint,action)|> Client.build_uri(node_config))
    response =
      Client.build_endpoint(endpoint,action)
      |> Client.build_uri(node_config)
      |> Client.post!(body|> Jason.encode!(),[],options)

    fun.(response)
  end

  def base_delete(%NodeConfig{} = node_config,endpoint,action,fun) do
    #IO.puts(Client.build_endpoint(endpoint,action)|> Client.build_uri(node_config))
    response =
      Client.build_endpoint(endpoint,action)
      |> Client.build_uri(node_config)
      |> Client.delete!()

    fun.(response)
  end
end
