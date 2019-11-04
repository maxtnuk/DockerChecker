defmodule Front.Utils do
  def convert(content) do
    content |>
    Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end

  def camel_convert(content) do
    content|>
    Map.new(fn {k, v} -> {String.to_atom(k) |> Macro.camelize, v} end)
  end
end
