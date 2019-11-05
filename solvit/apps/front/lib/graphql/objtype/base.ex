defmodule Front.Schema.ObjectType.Base do
  use Absinthe.Schema.Notation

  def replace_relay_connection_cursors(resolution, _) do
    case resolution.value do
      nil ->
        resolution
      _ ->
        new_edges = edges_cursors_to_object_id(resolution.value.edges)
        page_info = page_info_cursors_to_object_id(new_edges, resolution.value.page_info)

        resolution_value =
          resolution.value
          |> Map.replace!(:edges, new_edges)
          |> Map.replace!(:page_info, page_info)


        %{resolution | value: resolution_value}
    end
  end

  def edges_cursors_to_object_id(edges) do
    Enum.map(
      edges,
      fn edge -> %{edge | cursor: BSON.ObjectId.encode!(edge.node._id)} end
    )
  end

  def page_info_cursors_to_object_id(edges, page_info) when length(edges) == 0 do
    page_info
  end

  def page_info_cursors_to_object_id(edges, page_info) do
    page_info
    |> Map.replace!(:start_cursor, Enum.at(edges, 0).cursor)
    |> Map.replace!(:end_cursor, Enum.at(edges, -1).cursor)
  end

end
