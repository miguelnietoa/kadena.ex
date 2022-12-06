defmodule Kadena.Chainweb.Types.PollResponse do
  @moduledoc """
  `PollResponse` struct definition.
  """

  alias Kadena.Chainweb.Types.CommandResult
  alias Kadena.Types.Base64Url

  @behaviour Kadena.Types.Spec

  @type str :: String.t()
  @type key :: Base64Url.t()
  @type response :: CommandResult.t()
  @type value :: key() | response()
  @type validation :: {:ok, value()} | {:error, Keyword.t()}

  @type t :: %__MODULE__{key: key(), response: response()}

  defstruct [:key, :response]

  @impl true
  def new(attrs) do
    %CommandResult{req_key: key} =
      response =
      attrs
      |> Map.values()
      |> List.first()
      |> CommandResult.new()

    %__MODULE__{
      key: key,
      response: response
    }
  end
end
