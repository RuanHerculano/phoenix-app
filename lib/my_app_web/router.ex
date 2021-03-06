defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyAppWeb do
    pipe_through :api
    resources "/users", AccountsController, except: [:new, :edit]
  	get "/teste", AccountsController, :teste
  end
end
