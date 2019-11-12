defmodule Rest.Resolver do
  @base_url Application.get_env(:graphql, :base_url)

  def user_get(%{id: id}=args,_info) do
    """
    querry {
      user(user_id: {_eq #{args[:id]}}) {
        name
        profile
      }
    }
    """
    |> call_client(fn (x) ->
      case x do
        {:ok , content} -> content
        _ -> :error
      end
    end)
    |> Jason.encode!()
  end

  def call_client(query_str,func) do
    Neuron.Config.set(url: @base_url)
    Neuron.query(query_str)
    |> func.()
  end
end
