defmodule BodyHistory.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def databases do
    [
      {ETSDatabase, BodyHistory.Points.database()}
    ]
  end

  def start(_type, _args) do
    {ip,port} = {"0.0.0.0", 9100}
    children = [
      #Plug.Adapters.Cowboy.child_spec(:http,HTTP.Router,[], port: port, ip: elem(:inet.parse_address('#{ip}'),1), ref: {ip,port})
      {Plug.Cowboy, scheme: :http, plug: HTTP.Router, port: port}
    ] ++ databases()
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BodyHistory.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule HTTP.Router do
  use Plug.Router
  require Logger

  plug :cors
  defp cors(conn, _) do
    conn
    |> put_resp_header("Access-Control-Allow-Origin", "*")
    |> put_resp_header("Access-Control-Allow-Credentials", "true")
    |> put_resp_header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
    |> put_resp_header("Access-Control-Allow-Headers", "Content-Type, Origin")
    |> put_resp_header("Access-Control-Expose-Headers", "location")
    |> case do
      %{method: "OPTIONS"} = conn -> conn |> send_resp(200, "") |> halt()
      conn -> conn
    end
  end

  if Mix.env == :dev do #TODO Fix this for javascript
    plug Ewebmachine.Plug.Debug
    use Plug.Debugger
    plug Plug.Logger
    plug Plug.Static, at: "/dist", from: "priv/web/dist"
  else
    plug Plug.Static, at: "/dist", from: "priv/web/dist"
  end

  plug :fetch_cookies
  plug :fetch_query_params
  plug :match
  plug :dispatch

  def favicon_path, do: "#{:code.priv_dir(:body_history)}/images/favicon.ico"
  def index_html_path, do: "#{:code.priv_dir(:body_history)}/web/index.html"

  get "/favicon.ico", do: send_file(put_resp_content_type(conn, "image/x-icon"), 200, favicon_path())
  get "/robots.txt", do: send_resp(conn, 404,"User-agent: *\nDisallow: /\n")

  get "/api/*_", do: HTTP.Router.API.call(conn,[])

  get "*_" do
    send_file(put_resp_content_type(conn, "text/html"), 200, (index_html_path()))
  end
end
