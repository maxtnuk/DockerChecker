defmodule Solver do
  alias Docker.{
    Container,
    NodeConfig
  }
  use Application

  @sever_node NodeConfig.new(
                "https://54.180.124.55",
                2376,
                System.get_env("DOCKER_CERT_PATH")<>"/ca.pem",
                System.get_env("DOCKER_CERT_PATH")<>"/cert.pem",
                System.get_env("DOCKER_CERT_PATH")<>"/key.pem"
              )

  def start(_type, _args) do

  end
end
