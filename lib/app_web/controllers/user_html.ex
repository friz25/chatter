defmodule AppWeb.UserHTML do
  @moduledoc """
  This module contains pages rendered by UserController.
  """
  use AppWeb, :html

  embed_templates "user_html/*"
end
