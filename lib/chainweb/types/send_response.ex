defmodule Kadena.Chainweb.Resources.SendResponse do
  @moduledoc """
  `SendResponse` struct definition.
  """

  alias Kadena.Types.Base64UrlsList
  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Chainweb.Resource

  @type request_keys :: Base64UrlsList.t()

  @type t :: %__MODULE__{request_keys: request_keys()}

  defstruct request_keys: []

  @mapping [request_keys: {:struct, Base64UrlsList}]

  @impl true
  def new(attrs) do
    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
  end
end
