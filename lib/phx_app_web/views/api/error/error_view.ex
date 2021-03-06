defmodule PhxAppWeb.Api.Error.ErrorView do
  use PhxAppWeb, :view

  def template_forbidden(_template, _assigns) do
    %{
      statusCode: 403,
      message: "Forbidden😠"
    }
  end

  def template_not_found(_template, _assigns) do
    %{
      statusCode: 404,
      message: "Not found😳"
    }
  end

  def render("500.json", _assigns) do
    %{
      statusCode: 500,
      message: "Internal server error😇"
    }
  end
end
