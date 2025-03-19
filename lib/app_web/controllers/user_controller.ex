defmodule AppWeb.UserController do
  use AppWeb, :controller

  alias App.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()

    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    case Integer.parse(id) do #строку > в число
      {int_id, ""} ->
        user = Accounts.get_user(int_id)

        case user do
          nil -> #если такого юзера нет
            conn
            |> put_flash(:error, "User not found!")
            |> redirect(to: ~p"/users")

          _ -> #если такой юзер есть
            render(conn, :show, user: user)
        end

      _ -> #fallback
        conn
        |> put_flash(:error, "Invalid ID format!")
        |> redirect(to: ~p"/users")
    end
  end
end

#Домашнее задание:
#1) Добавить еще действие контролерра/View
#2) Как-то стилизовать Главную стр
