defmodule AppWeb.PageController do
  use AppWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  #[1]http://localhost:4000/about/City?company=Demo
  def about(conn, %{"location" => location} = params) do
    # company = Map.get(params, "company", "unknown")
    company = params |> Map.get("company", "unknown")

    render(conn, :about, company: company, location: location)
  end
end
