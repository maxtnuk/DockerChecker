defmodule Docker.ConnectConfig do
  alias Docker.{
    Container
  }

  @enforce_keys [:Container]
  @derive Jason.Encoder
  defstruct [
    :Container,
    :EndpointConfig,
  ]
  def new(%Container{} = container), do: new(container.id)
  def new(id) do
    %Docker.ConnectConfig{
      Container: id,
      EndpointConfig: %{}
    }
  end

  def add_ipv4(%Docker.ConnectConfig{} = connect_config,ip_addr) do
    ipam_config =
      connect_config
      |> Map.get(:EndpointConfig, %{})
      |> Map.get(:IPAMConfig, %{})
      |> Map.put(:IPv4Address, ip_addr)

      temp=
      connect_config
        |> Map.get(:EndpointConfig,%{})
        |> Map.put(:IPAMConfig,ipam_config)

      connect_config
        |> Map.put(:EndpointConfig,temp)
  end

  def add_ipv6(%Docker.ConnectConfig{} = connect_config,ip_addr) do
    ipam_config =
      connect_config
      |> Map.get(:EndpointConfig, %{})
      |> Map.get(:IPAMConfig, %{})
      |> Map.put(:IPv6Address, ip_addr)

    temp=
    connect_config
      |> Map.get(:EndpointConfig,%{})
      |> Map.put(:IPAMConfig,ipam_config)

    connect_config
      |> Map.put(:EndpointConfig,temp)
  end
end
