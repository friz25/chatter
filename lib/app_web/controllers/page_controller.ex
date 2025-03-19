defmodule AppWeb.PageController do
  use AppWeb, :controller

  plug :check_location when action in [:about] #[2]check_location
  plug :plug_me when action in [:about] #[2]plug_me будет вып перед каждым вызовом :about

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  #[1]http://localhost:4000/about/City?company=Demo
  def about(conn, %{"location" => location} = params) do
    # company = Map.get(params, "company", "unknown")
    company = params |> Map.get("company", "unknown") #company=Demo (смотри url выше)

    render(conn, :about, company: company, location: location) #даёт юзеру стр about.html
    # text(conn, "Company is #{company}, location is #{location}") #[2]даёт юзеру текст строку
    # conn
    # |> put_resp_content_type("application/json") #не обяз
    # |> put_status(202) #статус http ответа (не обяз)
    # |> json(%{location: location, company: company}) #[2]даёт юзеру json файл
    # conn |> send_resp(201, "") #[2]ответ "всё ок" (в api юзают это)
  end

  #[2]check_location // чек/валидация Если задан некоректный location (в url) то:
  # 1)выдать об этом инфу
  # 2)перенаправить юзера на другую стр
  defp check_location(%Plug.Conn{path_params: path_params} = conn, _opts) do
    path_params |> IO.inspect()

    location = path_params |> Map.get("location", "unknown")

    case location do
      #если "forbidden" > redirect юзера на главн стр
      #http://localhost:4000/about/forbidden?company=Demo&locale=en
      "forbidden" ->
        conn |> put_flash(:error, "Forbidden location!") |> redirect(to: ~p"/") |> halt()
        #put_flash(:error, "Forbidden location!") = всплывашка/сообщение
        #redirect(to: ~p"/") = перенаправь юзера на главн стр
        #halt() = дальше страница/conn выполняться не будет (ведь мы с неё уходим (на другую))

      _ -> #fallback
        conn
    end
  end

  #[2]plug_me // "всплывашка"
  defp plug_me(conn, opts) do
    IO.puts("INSPECTING OPTS")
    opts |> IO.inspect()
    IO.puts("=====")

    IO.puts("INSPECTING CONN")
    conn |> IO.inspect()
    IO.puts("=====")

    conn |> put_flash(:info, "Check ok!") |> assign(:plugged, true) #(!)обяз вконце вернуть
    #put_flash = всплывашка/сообщение
  end

  #[2]будет выдавать список всех юзеров сайта
  #и выдавать detail инфу об отдельных юзерах
  
end
