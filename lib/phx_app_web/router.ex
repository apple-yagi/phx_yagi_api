defmodule PhxAppWeb.Router do
  use PhxAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PhxApp.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", PhxAppWeb.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", PhxAppWeb.Api do
    pipe_through :api

    scope "/auth", Auth do
      post "/sign_in", JwtController, :sign_in
    end

    scope "/v1", V1 do
      resources "/users", UserController, only: [:index, :create]
      get "/users/:name", UserController, :show
      resources "/articles", ArticleController, only: [:index]
      get "/users/:username/articles/:id", ArticleController, :show
      resources "/tags", TagController, only: [:index]
      get "/tags/:name", TagController, :show

      pipe_through [:auth, :ensure_auth]

      resources "/users", UserController, only: [:update, :delete]
      resources "/articles", ArticleController, only: [:create, :update, :delete]
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PhxAppWeb.Telemetry
    end
  end
end
