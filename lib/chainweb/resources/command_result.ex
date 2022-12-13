defmodule Kadena.Chainweb.Resources.CommandResult do
  @moduledoc """
  `CommandResult` struct definition.
  """

  alias Kadena.Types.{
    Base64Url
  }

  alias Kadena.Chainweb.Resources.{
    PactResult,
    PactEventsList,
    ResponseMetaData,
    PactExec
  }

  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Chainweb.Resource

  @type str :: String.t()
  @type req_key :: Base64Url.t()
  @type tx_id :: number() | nil
  @type result :: PactResult.t()
  @type gas :: number()
  @type logs :: String.t() | nil
  @type continuation :: PactExec.t() | nil
  @type meta_data :: ResponseMetaData.t() | nil
  @type events :: PactEventsList.t() | nil

  @type t :: %__MODULE__{
          req_key: req_key(),
          tx_id: tx_id(),
          result: result(),
          gas: gas(),
          logs: logs(),
          continuation: continuation(),
          meta_data: meta_data(),
          events: events()
        }

  defstruct [:req_key, :tx_id, :result, :gas, :logs, :continuation, :meta_data, :events]

  @mapping [
    req_key: {:struct, Base64Url},
    result: {:struct, PactResult},
    continuation: {:struct, PactExec},
    meta_data: {:struct, ResponseMetaData},
    events: {:struct, PactEventsList}
  ]

  @impl true
  def new(attrs) do
    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
  end
end
