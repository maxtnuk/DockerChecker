defmodule Docker.Container do
  alias Docker.{
    Base,
    NodeConfig
  }

  @enforce_keys [:node_config, :id]
  defstruct [
    :node_config,
    :id,
    :command,
    :created,
    :image,
    :image_id,
    :labels,
    :mounts,
    :names,
    :ports,
    :state,
    :status
  ]
  @containers_uri "/containers"


  def list(%NodeConfig{} = node_config,options) do
    Base.base(node_config,@containers_uri,"/json",options,fn (response) ->
      case response.status_code do
      200 ->
        Enum.map(response.body, fn container ->
          to_container(container, node_config)
        end)

      _ ->
        raise "unable to list containers"
      end
    end)
  end
  def list_all(%NodeConfig{} = node_config) do
    options = [params: %{"all" => true}]
    list(node_config,options)
  end

  defp to_container(%{} = container, %NodeConfig{} = node_config) do
    %Docker.Container{
      node_config: node_config,
      id: container["Id"],
      command: container["Command"],
      created: container["Created"],
      image: container["Image"],
      image_id: container["ImageID"],
      labels: container["Labels"],
      mounts: container["Mounts"],
      names: container["Names"],
      ports: container["Ports"],
      state: container["State"],
      status: container["Status"]
    }
  end
end
