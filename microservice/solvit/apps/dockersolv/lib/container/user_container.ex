defmodule Docker.UserContainer do
  defstruct [
    :user_name,
    :problem_no,
    :compose,
    :sourcefile,
    :dockerfile
  ]

  def new(user_name,problemno,compose,dockerfile,sourcefile) do
    %Docker.UserContainer{
      user_name: user_name,
      compose: compose,
      problem_no: problemno,
      dockerfile: dockerfile,
      sourcefile: sourcefile
    }
  end

end
