defmodule App.Accounts do
  @moduledoc """
  Accounts
  """

  alias App.Accounts.User

  #наша псевдо БД / список юзеров
  def list_users do #обяз
    [
      %User{id: 1, username: :john, name: "John", surname: "Doe"},
      %User{id: 2, username: :ann, name: "Ann", surname: "Smith"}
    ]
  end

  def get_user(id) do
    #получ инфу о юзере (ищет юзера по id)
    Enum.find(list_users(), &(&1.id == id))
  end
end
