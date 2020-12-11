defmodule MyappWeb.SessionController do
  use MyappWeb, :controller

  alias Myapp.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def delete(conn, _) do
    conn
    |> delete_session(:user)
    |> put_flash(:info, "Logged out successfully!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def create(conn, %{"user" => %{"email" => email, "raw_password" => raw_password}}) do
    try_login = Accounts.get_user_by_email(email) |> Accounts.login(raw_password)
    do_create(conn, try_login)
  end

  # -- private method --

  defp do_create(conn, {:ok, login_user}) do
    conn
    |> put_flash(:info, "Logged in successfully!")
    |> put_session(:user, %{
      id: login_user.id,
      name: login_user.name,
      email: login_user.email
    })
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp do_create(conn, _) do
    conn
    |> put_flash(:error, "Invalid username/password!")
    |> render("new.html", current: nil)
  end
end
