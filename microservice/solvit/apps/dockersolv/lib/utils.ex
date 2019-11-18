defmodule Docker.Utils do

  @codespace_path Application.get_env(:dockersolv, :source_path)

  def tar_to_string(source, %Docker.UserContainer{user_name: user, problem_no: problem} = _argc) do

    files =
      source
      |> Enum.map(
           fn (x) ->
             {"pro_" <> Integer.to_string(problem) <> "/" <> x["file_name"], <<"#{x["source"]}">>}
           end
         )

    zip_path = @codespace_path <> "/" <> user

    #IO.puts(files)
    tarname = "pro_" <> Integer.to_string(problem) <> ".tar"

    :filelib.ensure_dir(zip_path <> "/")

    #{:ok,_}=:erl_tar.create(zip_path <> "/" <>  tarname, files, compressed: true)

    bit_string = ""
    #   #(zip_path <> "/" <> tarname)
    #   #|> File.read!()
    # #
    bit_string
  end
end
