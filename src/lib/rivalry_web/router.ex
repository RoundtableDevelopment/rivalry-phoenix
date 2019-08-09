defmodule RivalryWeb.Router do
  use RivalryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RivalryWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RivalryWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/registrations", RegistrationController, only: [:new, :create]

    scope "/" do
      pipe_through [:authenticate_user]
      resources "/users", UserController, only: [:edit, :update]
    end
  end

  scope "/admin", RivalryWeb.Admin, as: :admin do
    pipe_through [:browser, :authenticate_user, :authenticate_admin]

    resources "/users", UserController, only: [:index, :delete]
  end


  # Other scopes may use custom stacks.
  # scope "/api", RivalryWeb do
  #   pipe_through :api
  # end
end
