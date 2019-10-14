defmodule Docker.NetworkConfig do

  @enforce_keys [:Name]
  @derive Jason.Encoder
  defstruct [
    :Name,
    :IPAM,
  ]
  def new(name) do
    %Docker.NetworkConfig{
      Name: name,
      IPAM: %{}
    }
  end

  def add_ipsetting(%Docker.NetworkConfig{} = network_config,ip_setting) do
    ip_setting =
      network_config
      |> Map.get(:IPAM,%{})
      |> Map.get(:Config,[])
      |> List.insert_at(-1,ip_setting)

    config =   network_config
      |> Map.get(:IPAM,%{})
      |> Map.put(:Config,ip_setting)

    network_config |> Map.put(:IPAM,config)
  end
end
