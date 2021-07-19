defmodule PhxAppWeb.Api.V1.ArticleView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.ArticleView
  alias PhxAppWeb.Api.V1.UserView

  def render("index.json", %{articles: articles}) do
    render_many(articles, ArticleView, "article.json")
  end

  def render("show.json", %{article: article}) do
    render_one(article, ArticleView, "article.json")
    |> Map.put_new(:user, render_one(article.user, UserView, "user.json"))
  end

  def render("article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
      content: article.content,
      createdAt: article.inserted_at,
      updatedAt: article.updated_at
    }
  end
end
