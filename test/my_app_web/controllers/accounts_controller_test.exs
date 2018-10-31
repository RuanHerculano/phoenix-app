defmodule MyAppWeb.AccountsControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.User
  alias MyApp.User.Accounts

  @create_attrs %{name: "some name", quantity: 42}
  @update_attrs %{name: "some updated name", quantity: 43}
  @invalid_attrs %{name: nil, quantity: nil}

  def fixture(:accounts) do
    {:ok, accounts} = User.create_accounts(@create_attrs)
    accounts
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, accounts_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create accounts" do
    test "renders accounts when data is valid", %{conn: conn} do
      conn = post conn, accounts_path(conn, :create), accounts: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, accounts_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "quantity" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, accounts_path(conn, :create), accounts: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update accounts" do
    setup [:create_accounts]

    test "renders accounts when data is valid", %{conn: conn, accounts: %Accounts{id: id} = accounts} do
      conn = put conn, accounts_path(conn, :update, accounts), accounts: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, accounts_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "quantity" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, accounts: accounts} do
      conn = put conn, accounts_path(conn, :update, accounts), accounts: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete accounts" do
    setup [:create_accounts]

    test "deletes chosen accounts", %{conn: conn, accounts: accounts} do
      conn = delete conn, accounts_path(conn, :delete, accounts)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, accounts_path(conn, :show, accounts)
      end
    end
  end

  defp create_accounts(_) do
    accounts = fixture(:accounts)
    {:ok, accounts: accounts}
  end
end
