defmodule AppWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "ru", "lv"]
  @default_fallback "en"

  #[2]=====(!)обяз должен быть init====
  def init(default) when default in @locales, do: default
  def init(_default), do: @default_fallback

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end

  #[2]===(!)обяз должен быть call/2====
  def call(conn, default) do #fallback
    assign(conn, :locale, default)
  end
end
