defmodule MyAppWeb.AccountsController do
  use MyAppWeb, :controller

  alias MyApp.User
  alias MyApp.User.Accounts

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    users = User.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"accounts" => accounts_params}) do
    require IEx; IEx.pry
    with {:ok, %Accounts{} = accounts} <- User.create_accounts(accounts_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", accounts_path(conn, :show, accounts))
      |> render("show.json", accounts: accounts)
    end
  end

  def show(conn, %{"id" => id}) do
    accounts = User.get_accounts!(id)
    render(conn, "show.json", accounts: accounts)
  end

  def update(conn, %{"id" => id, "accounts" => accounts_params}) do
    accounts = User.get_accounts!(id)

    with {:ok, %Accounts{} = accounts} <- User.update_accounts(accounts, accounts_params) do
      render(conn, "show.json", accounts: accounts)
    end
  end

  def delete(conn, %{"id" => id}) do
    accounts = User.get_accounts!(id)
    with {:ok, %Accounts{}} <- User.delete_accounts(accounts) do
      send_resp(conn, :no_content, "")
    end
  end

  def test(conn, _params) do
    users = User.list_users()
    render(conn, "index.json", users: users)
  end
end
