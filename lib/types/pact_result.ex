defmodule Kadena.Types.PactResult do
  @moduledoc """
  `PactResult` struct definition.
  """

  alias Kadena.Types.PactValue
  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Types.Spec

  @type status :: :success | :failure
  @type error :: map()
  @type data :: PactValue.t() | error()
  @type value :: status() | data()
  @type validation :: {:ok, value()} | {:error, Keyword.t()}

  @type t :: %__MODULE__{
          status: status(),
          data: data()
        }

  defstruct [:status, :data]

  @mapping [status: :atom]

  @impl true
  def new(attrs) do
    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
  end
end
