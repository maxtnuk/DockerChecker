defmodule Docker.ContainerTest do
  use ExUnit.Case

  alias Docker.{
    Container,
    NodeConfig,
    Filter
  }

  @node_config NodeConfig.new(
                 "https://54.180.124.55",
                 2376,
                 System.get_env("DOCKER_CERT_PATH") <> "/ca.pem",
                 System.get_env("DOCKER_CERT_PATH") <> "/cert.pem",
                 System.get_env("DOCKER_CERT_PATH") <> "/key.pem"
               )
  @codespace_path System.get_env("SOLVE_WORKSPACE")

  @tag :ls_c
  test "list container" do
    containers = Container.list_all(@node_config)
    assert is_list(containers)
  end

  @tag :new_c
  test "new container" do
    container = Container.list_all(@node_config)
    inspect_status(container, "created")

    result = Container.start(container)
    assert result == container
    result = Container.stop(container)
    assert result == container

    response = Container.remove(container)
    assert response == :ok
  end

  @tag :cp_c
  test "copy file" do
    filter = Filter.new("space")
    # filter |> Jason.encode!()
    # IO.puts(filter |> Jason.encode!())
    options = [params: %{"all" => true, "filters" => filter |> Jason.encode!()}]
    # IO.puts(options)
    containers = @node_config |> Container.list(options)
    # IO.puts(containers)
    # containers = Container.list(@node_config, options)

    result =
      containers
      |> Enum.at(0)
      |> Container.copy_file(@codespace_path, "user12", "p100")

    assert result == :ok
  end

  defp inspect_status(container, expected_status) do
    status = Container.get_status(container)
    IO.puts(status)
    assert status == expected_status
  end
end
