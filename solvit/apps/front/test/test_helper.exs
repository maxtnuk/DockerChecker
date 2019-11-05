ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Front.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
