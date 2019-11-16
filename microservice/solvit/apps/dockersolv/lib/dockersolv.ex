defmodule Docker do

  alias Docker.{
    Container,
    ConnectConfig,
    Network,
    NodeConfig,
    NetworkConfig,
    UserContainer,
    Image,
    Utils,
    Compose
  }

  @node_base Application.get_env(:dockersolv, :node_config)

  @node_config NodeConfig.new(
    @node_base[:url],
    @node_base[:port],
    @node_base[:docker_ca],
    @node_base[:docker_cert],
    @node_base[:docker_key]
  )

  #deprecate
  def run(user_config) do

    result=@node_config |>
    Compose.compose_run(user_config.compose)
    {:ok, result}
  end

  def list() do
    result=
    @node_config |> Compose.list_container()
    {:ok, result}
  end

  def remove(id) do
    result=
    Container.remove(%Docker.Container{
      id: id,
      node_config: @node_config
    })
    |> case do
      :ok ->  {:ok, %{
        container_id: id
      }}
      :err -> {:ok, %{
        container_id: ""
      }}
    end

  end
end
