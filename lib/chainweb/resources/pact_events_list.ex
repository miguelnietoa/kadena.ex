defmodule Kadena.Chainweb.Resources.PactEventsList do
  @moduledoc """
  `PactEventsList` struct definition.
  """
  alias Kadena.Chainweb.Resources.PactEvent
  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Chainweb.Resource

  @type pact_event :: PactEvent.t()
  @type pact_events :: list(pact_event())

  @type t :: %__MODULE__{pact_events: pact_events()}

  defstruct pact_events: []

  @mapping [pact_events: {:list, :struct, PactEvent}]

  @impl true
  def new(pact_events) do
    attrs = %{"pact_events" => pact_events}

    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
  end
end
