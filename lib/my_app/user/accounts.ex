defmodule MyApp.User.Accounts do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, [:name, :quantity])
    |> validate_required([:name, :quantity])
  end
end
