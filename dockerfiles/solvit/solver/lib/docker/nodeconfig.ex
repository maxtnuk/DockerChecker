defmodule Docker.NodeConfig do

  @enforce_keys [:hostname, :port]
  defstruct [:hostname, :port, :ssl, :label]

  def new() do
    %Docker.NodeConfig{
      hostname: "localhost",
      port: 2376
    }
  end

  def new(hostname, port) do
    new(hostname)
    |> Map.put(:port,port)
  end

  def new(hostname) do
   new()
   |> Map.put(:hostname,hostname)
  end


  def new(hostname, port, cacertfile, certfile, keyfile) do
    %Docker.NodeConfig{
      hostname: hostname,
      port: port,
      ssl: [
        cacertfile: cacertfile,
        certfile: certfile,
        keyfile: keyfile
      ]
    }
  end

  def new(hostname, port, certfile, keyfile) do
    %Docker.NodeConfig{
      hostname: hostname,
      port: port,
      ssl: [
        certfile: certfile,
        keyfile: keyfile
      ]
    }
  end

  def set_label(%Docker.NodeConfig{} = node_config, label) do
    node_config |> Map.put(:label, label)
  end

  def get_options(%Docker.NodeConfig{ssl: nil} = _node_config), do: []

  def get_options(node_config) do
    [
      ssl: node_config.ssl
    ]
  end

end
