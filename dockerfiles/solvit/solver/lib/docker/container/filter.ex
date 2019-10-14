defmodule Docker.Filter do
  @derive Jason.Encoder
  defstruct [
    :name
  ]

  def new(name) do
    %Docker.Filter{
      name: [name]
    }
  end
end
