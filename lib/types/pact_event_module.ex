defmodule Kadena.Types.PactEventModule do
  @moduledoc """
  `PactEventModule` struct definition.
  """

  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Types.Spec

  @type name :: String.t()
  @type namespace :: String.t() | nil
  @type value :: name() | namespace()
  @type validation :: {:ok, value()} | {:error, Keyword.t()}

  @type t :: %__MODULE__{name: name(), namespace: namespace()}

  defstruct [:name, :namespace]

  @impl true
  def new(args) when is_list(args) do
    name = Keyword.get(args, :name)
    namespace = Keyword.get(args, :namespace)

    with {:ok, name} <- validate_string(:name, name),
         {:ok, namespace} <- validate_string(:namespace, namespace) do
      %__MODULE__{name: name, namespace: namespace}
    end
  end

  def new(attrs) when is_map(attrs), do: Mapping.build(%__MODULE__{}, attrs)

  @spec validate_string(field :: atom(), value :: value()) :: validation()
  defp validate_string(_field, value) when is_binary(value), do: {:ok, value}
  defp validate_string(:namespace, nil), do: {:ok, nil}
  defp validate_string(field, _value), do: {:error, [{field, :invalid}]}
end
