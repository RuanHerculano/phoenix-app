defmodule MyApp.UserTest do
  use MyApp.DataCase

  alias MyApp.User

  describe "users" do
    alias MyApp.User.Accounts

    @valid_attrs %{name: "some name", quantity: 42}
    @update_attrs %{name: "some updated name", quantity: 43}
    @invalid_attrs %{name: nil, quantity: nil}

    def accounts_fixture(attrs \\ %{}) do
      {:ok, accounts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_accounts()

      accounts
    end

    test "list_users/0 returns all users" do
      accounts = accounts_fixture()
      assert User.list_users() == [accounts]
    end

    test "get_accounts!/1 returns the accounts with given id" do
      accounts = accounts_fixture()
      assert User.get_accounts!(accounts.id) == accounts
    end

    test "create_accounts/1 with valid data creates a accounts" do
      assert {:ok, %Accounts{} = accounts} = User.create_accounts(@valid_attrs)
      assert accounts.name == "some name"
      assert accounts.quantity == 42
    end

    test "create_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_accounts(@invalid_attrs)
    end

    test "update_accounts/2 with valid data updates the accounts" do
      accounts = accounts_fixture()
      assert {:ok, accounts} = User.update_accounts(accounts, @update_attrs)
      assert %Accounts{} = accounts
      assert accounts.name == "some updated name"
      assert accounts.quantity == 43
    end

    test "update_accounts/2 with invalid data returns error changeset" do
      accounts = accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_accounts(accounts, @invalid_attrs)
      assert accounts == User.get_accounts!(accounts.id)
    end

    test "delete_accounts/1 deletes the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Accounts{}} = User.delete_accounts(accounts)
      assert_raise Ecto.NoResultsError, fn -> User.get_accounts!(accounts.id) end
    end

    test "change_accounts/1 returns a accounts changeset" do
      accounts = accounts_fixture()
      assert %Ecto.Changeset{} = User.change_accounts(accounts)
    end
  end
end
