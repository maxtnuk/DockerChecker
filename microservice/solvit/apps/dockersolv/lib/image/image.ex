defmodule Docker.Image do
  alias Docker.{
    Base,
    NodeConfig,
    ContainerConfig
  }

  @enforce_keys [:node_config, :id]
  defstruct [
    :node_config,
    :id,
    :image_name
  ]

  @build_uri "/image"

  def build(%NodeConfig{} = node_config,dockerfile,source) do
    Base.base_post(
      node_config,
      "",
      "/build",
      source,
      [params: %{"dockerfile" => dockerfile["source"],"t" => dockerfile["image_name"]}],
      fn response ->
        case response.status_code do
          200 ->
            %{
              ok: dockerfile["image_name"]
            }
          _ ->
            raise "unable to build_image containers"
        end
      end
    )
  end

end
