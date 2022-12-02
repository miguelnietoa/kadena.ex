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

  @mapping [
    status: :atom
  ]

  @impl true
  def new(args) when is_list(args) do
    status = Keyword.get(args, :status)
    data = Keyword.get(args, :data)

    with {:ok, status} <- validate_status(status),
         {:ok, data} <- validate_data(status, data) do
      %__MODULE__{status: status, data: data}
    end
  end

  def new(attrs) when is_map(attrs) do
    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
    |> new()
  end

  @spec validate_status(status :: status()) :: validation()
  def validate_status(status) when status in [:success, :failure], do: {:ok, status}
  def validate_status(_status), do: {:error, [status: :invalid]}

  @spec validate_data(status :: status(), data :: data()) :: validation()
  def validate_data(:failure, %{} = data), do: {:ok, data}
  def validate_data(:success, %PactValue{} = data), do: {:ok, data}

  def validate_data(:success, data) do
    case PactValue.new(data) do
      %PactValue{} = data -> {:ok, data}
      {:error, reason} -> {:error, [data: :invalid] ++ reason}
    end
  end

  def validate_data(_status, _data), do: {:error, [data: :invalid]}
end
