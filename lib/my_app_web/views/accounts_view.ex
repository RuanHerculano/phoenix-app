defmodule MyAppWeb.AccountsView do
  use MyAppWeb, :view
  alias MyAppWeb.AccountsView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, AccountsView, "accounts.json")}
  end

  def render("show.json", %{accounts: accounts}) do
    %{data: render_one(accounts, AccountsView, "accounts.json")}
  end

  def render("accounts.json", %{accounts: accounts}) do
    %{id: accounts.id,
      name: accounts.name,
      quantity: accounts.quantity}
  end
end
