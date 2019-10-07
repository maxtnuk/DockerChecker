defmodule Docker.ContainerConfig do

  @enforce_keys [:Image]
  @derive Jason.Encoder
  defstruct [
    :Env,
    :HostConfig,
    :Image
  ]

  def new(image_name) do
    %Docker.ContainerConfig{
      Env: [],
      HostConfig: %{},
      Image: image_name
    }
  end

  def add_env(%Docker.ContainerConfig{} = container_config, key, value) do
   env =
     Map.get(container_config, :Env)
     |> List.insert_at(-1, key <> "=" <> value)

   container_config
   |> Map.put(:Env, env)
  end

 def add_dns_option(
       %Docker.ContainerConfig{} = container_config,
       dns_option
     ) do
   dns_options =
     container_config
     |> Map.get(:HostConfig, %{})
     |> Map.get(:DnsOptions, [])
     |> List.insert_at(-1, dns_option)

   update_host_config(container_config, :DnsOptions, dns_options)
  end

  def update_host_config(
         %Docker.ContainerConfig{} = container_config,
         key,
         value
       ) do
     host_config =
       container_config
       |> Map.get(:HostConfig, %{})
       |> Map.put(key, value)

     container_config
     |> Map.put(:HostConfig, host_config)
  end
end
