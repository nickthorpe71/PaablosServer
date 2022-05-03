defmodule PaablosServer do
  use Application

  # Tutorial Article:
  # https://medium.com/@loganbbres/elixir-websocket-chat-example-c72986ab5778

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: PaablosServer.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      ),
      Registry.child_spec(
        keys: :duplicate,
        name: Registry.PaablosServer
      )
    ]

    opts = [strategy: :one_for_one, name: PaablosServer.Applicaiton]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws/[...]", PaablosServer.SocketHandler, []},
         {:_, Plug.Cowboy.Handler, {PaablosServer.Router, []}}
       ]}
    ]
  end
end
