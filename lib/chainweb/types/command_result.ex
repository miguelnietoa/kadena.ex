defmodule Kadena.Chainweb.Types.CommandResult do
  @moduledoc """
  `CommandResult` struct definition.
  """

  alias Kadena.Types.{
    Base64Url,
    ChainwebResponseMetaData,
    OptionalPactEventsList,
    PactEventsList,
    PactExec,
    PactResult
  }

  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Types.Spec

  @type str :: String.t()
  @type req_key :: Base64Url.t()
  @type tx_id :: number() | nil
  @type result :: PactResult.t()
  @type gas :: number()
  @type logs :: String.t() | nil
  @type continuation :: PactExec.t() | nil
  @type meta_data :: ChainwebResponseMetaData.t() | nil
  @type events :: OptionalPactEventsList.t()
  @type events_arg :: PactEventsList.t() | list() | nil
  @type value ::
          str()
          | req_key()
          | tx_id()
          | result()
          | gas()
          | logs()
          | continuation()
          | meta_data()
          | events()
  @type validation :: {:ok, value()} | {:error, Keyword.t()}

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
    meta_data: {:struct, ChainwebResponseMetaData},
    events: {:struct, OptionalPactEventsList}
  ]

  @impl true
  def new(attrs) do
    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
  end
end
