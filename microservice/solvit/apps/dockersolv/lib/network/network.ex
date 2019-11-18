defmodule Docker.Network do
  alias Docker.{
    Base,
    NodeConfig,
    NetworkConfig,
    Container,
    ConnectConfig
    }

  @enforce_keys [:node_config, :id]
  defstruct [
    :name,
    :id,
    :node_config,
    :created,
    :scope,
    :driver,
    :enable_ipv6,
    :internal,
    :attachable,
    :ingress,
    :ipam,
    :options,
    :containers
  ]

  @network_uri "/networks"

  def list(%NodeConfig{} = node_config, options) do
    Base.base_get(
      node_config,
      @network_uri,
      nil,
      options,
      fn response ->
        case response.status_code do
          200 ->
            Enum.map(
              response.body,
              fn network ->
                to_network(network, node_config)
              end
            )

          _ ->
            raise "unable to list network"
        end
      end
    )
  end

  def list(%NodeConfig{} = node_config), do: list(node_config, [])

  def get_status(%Docker.Network{} = network, options) do
    Base.base_get(
      network.node_config,
      @network_uri,
      network.id,
      options,
      fn response ->
        case response.status_code do
          200 ->
            to_network(response.body, network.node_config)

          _ ->
            raise "unable to inspect network"
        end
      end
    )
  end

  def get_status(%Docker.Network{} = network), do: get_status(network, [])

  def create(%NodeConfig{} = node_config, %Docker.NetworkConfig{} = network_config) do
    Base.base_post(
      node_config,
      @network_uri,
      "create",
      network_config,
      [],
      fn response ->
        case response.status_code do
          201 ->
            %Docker.Network{
              id: response.body["Id"],
              node_config: node_config
            }

          # IO.puts(response.status_code)
          _ ->
            raise "unable to create network"
        end
      end
    )
  end

  def create(%NodeConfig{} = node_config, name), do: create(node_config, NetworkConfig.new(name))

  def remove(%Docker.Network{} = network) do
    Base.base_delete(
      network.node_config,
      @network_uri,
      network.id,
      fn response ->
        case response.status_code do
          204 -> :ok
          _ -> raise "unable to delete network: " <> network.id
        end
      end
    )
  end

  def connect(%Docker.Network{} = network, %ConnectConfig{} = connect_config) do
    Base.base_post(
      network.node_config,
      @network_uri,
      network.id <> "/connect",
      connect_config,
      [],
      fn response ->
        case response.status_code do
          200 ->
            :ok

          # IO.puts(response.status_code)
          _ ->
            raise "unable to connect network"
        end
      end
    )
  end

  def disconnect(%Docker.Network{} = network, %ConnectConfig{} = connect_config) do
    Base.base_post(
      network.node_config,
      @network_uri,
      network.id <> "/disconnect",
      connect_config,
      [],
      fn response ->
        case response.status_code do
          200 ->
            :ok

          # IO.puts(response.status_code)
          _ ->
            raise "unable to disconnect network"
        end
      end
    )
  end

  def to_network(%{} = network, %NodeConfig{} = node_config) do
    %Docker.Network{
      name: network["Name"],
      id: network["Id"],
      node_config: node_config,
      created: network["Created"],
      scope: network["Scope"],
      driver: network["Driver"],
      enable_ipv6: network["EnableIPv6"],
      internal: network["Internal"],
      attachable: network["Attachable"],
      ingress: network["Ingress"],
      ipam: network["IPAM"],
      options: network["Options"],
      containers: network["Containers"]
    }
  end
end
