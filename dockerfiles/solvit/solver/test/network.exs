defmodule Docker.NetworkTest do
  use ExUnit.Case

  alias Docker.{
    Container,
    ConnectConfig,
    Network,
    NodeConfig,
    NetworkConfig
  }

  @node_config NodeConfig.new(
                "https://54.180.124.55",
                2376,
                System.get_env("DOCKER_CERT_PATH")<>"/ca.pem",
                System.get_env("DOCKER_CERT_PATH")<>"/cert.pem",
                System.get_env("DOCKER_CERT_PATH")<>"/key.pem"
              )
  test "list network" do
    networks = Network.list(@node_config)
    #IO.puts(networks)
    assert is_list(networks)

    status = Network.get_status(networks |> Enum.at(0))
    assert status == networks |> Enum.at(0)

    created = Network.create(@node_config,"hello")

    result = Network.remove(created)
    assert result==:ok
  end

  test "connect network" do
    network_config = NetworkConfig.new("hellon")
            |> NetworkConfig.add_ipsetting(
            %{Gateway: "172.20.10.1", Subnet: "172.20.10.0/24"}
            )

    #IO.puts(network_config)
    created = Network.create(@node_config,network_config)

    container = Container.create(@node_config,"helloc","busybox")

    connect_config = ConnectConfig.new(container) |> ConnectConfig.add_ipv4("172.20.10.2")
    result = Network.connect(created,connect_config)
    assert result == :ok

    result = Network.disconnect(created,connect_config)
    assert result == :ok

    result = Network.remove(created)
    assert result==:ok

    result = Container.remove(container)
    assert result==:ok
  end
end
