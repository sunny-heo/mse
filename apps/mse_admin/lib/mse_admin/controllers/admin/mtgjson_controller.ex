defmodule Mse.Admin.MtgjsonController do
  use Mse.Admin, :controller

  def update(conn, _params) do
    Workers.Admin.MtgjsonImport.perform_async()

    redirect(conn, to: "/")
  end
end
