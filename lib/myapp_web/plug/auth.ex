defmodule MyappWeb.Plug.Auth do
  alias MyappWeb.Router.Helpers, as: Routes
  import Plug.Conn, only: [get_session: 2, halt: 1]
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    if is_auth?(conn) do
      conn
    else
      conn
        |> put_flash(:error, "You need login!!")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end
  end

  defp is_auth?(conn) do
    get_session(conn, :user) # 取得できなかったら nil が返る
  end
end
