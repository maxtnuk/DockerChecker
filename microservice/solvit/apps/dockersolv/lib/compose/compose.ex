defmodule Docker.Compose do

  alias Docker.{
    Container,
    ConnectConfig,
    Network,
    NodeConfig,
    NetworkConfig,
    UserContainer,
    Image,
    Utils
    }

  def compose_run(%NodeConfig{} = node_config, file)  do
    #{:ok, containers}=YAML.decode(file)

    file
    |> Enum.map(
         fn (x) ->
           node_config
           |> Container.create("", x["container_image"])
           |> case do
                %Docker.Container{} = x ->
                  Container.start(x)
                y -> y
              end
         end
       )
  end
  def list_container(%NodeConfig{} = node_config) do
    node_config
    |> Container.list_all()
    |> Enum.map(
         fn (x) ->
           %{
             container_id: x.id,
             image_name: x.image,
             status: x.status
           }
         end
       )
  end
end
