defmodule RemoteDockers.ContainerTest do
  use ExUnit.Case

  alias Docker.{
    Container,
    NodeConfig,
  }

  @node_config NodeConfig.new(
                "https://54.180.124.55",
                2376,
                System.get_env("DOCKER_CERT_PATH")<>"/ca.pem",
                System.get_env("DOCKER_CERT_PATH")<>"/cert.pem",
                System.get_env("DOCKER_CERT_PATH")<>"/key.pem"
              )
  test "list container" do
    containers = Container.list_all(@node_config)
    assert is_list(containers)
  end
end
