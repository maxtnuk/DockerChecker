defmodule Docker.Container do
  alias Docker.{
    Base,
    NodeConfig,
    ContainerConfig
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
    Base.base_get(node_config,@containers_uri,"/json",options,fn (response) ->
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

  def create(%NodeConfig{} = node_config,name,%ContainerConfig{}=container_config) do
    Base.base_post(node_config,@containers_uri,"create?name="<>name,container_config,[],fn (response) ->
      case response.status_code do
      201 ->
        %Docker.Container{
          id: response.body["Id"],
          node_config: node_config
        }
      _ ->
        raise "unable to create containers"
      end
    end)
  end

  def create(%NodeConfig{} = node_config, name, image_name) do
    create(node_config, name, ContainerConfig.new(image_name))
  end

  def start(%Docker.Container{} = container) do
    Base.base_post(container.node_config,@containers_uri,container.id<>"/start","",[],fn (response) ->
      #IO.puts(response.body)
      case response.status_code do
        204 -> container
      _ -> raise "unable to start container: " <> container.id
      end
    end)
  end

  def stop(%Docker.Container{} = container) do
    Base.base_post(container.node_config,@containers_uri,container.id<>"/stop","",[],fn (response) ->
      case response.status_code do
        204 -> container
      _ -> raise "unable to stop container: " <> container.id
      end
    end)
  end

  def get_status(%Docker.Container{} = container) do
    Base.base_get(container.node_config,@containers_uri,container.id<>"/json",[],fn (response) ->
      case response.status_code do
        200 -> response.body["State"]["Status"]
         _ -> raise "unable to retrieve container: " <> container.id
      end
    end)
  end

  def remove(%Docker.Container{} = container) do
    Base.base_delete(container.node_config,@containers_uri,container.id,fn (response) ->
      case response.status_code do
        204 -> :ok
        _ -> raise "unable to delete container: " <> container.id
      end
    end)
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
