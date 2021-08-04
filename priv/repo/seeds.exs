# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhxApp.Repo.insert!(%PhxApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

PhxApp.Repo.Seeds.UserSeeder.seed()
PhxApp.Repo.Seeds.TagSeeder.seed()
PhxApp.Repo.Seeds.ArticleSeeder.seed()
PhxApp.Repo.Seeds.ArticleTagSeeder.seed()
