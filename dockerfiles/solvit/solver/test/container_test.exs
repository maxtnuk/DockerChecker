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
  test "new container" do
    container = Container.create(@node_config,"hello","busybox")
    inspect_status(container,"created")

    result =Container.start(container)
    assert result == container
    result = Container.stop(container)
    assert result == container

    response = Container.remove(container)
    assert response == :ok
  end


  defp inspect_status(container, expected_status) do
    status = Container.get_status(container)
    IO.puts(status)
    assert status == expected_status
  end
end
