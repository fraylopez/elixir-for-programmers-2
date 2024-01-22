defmodule B1Web.PageHTML do
  use B1Web, :html

  embed_templates "page_html/*"

  def pluralize(1, singular), do: "one " <> singular
  def pluralize(n, singular, plural \\ nil), do: plural || to_string(n) <> " " <> singular <> "s"
end
