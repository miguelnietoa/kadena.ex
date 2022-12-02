defmodule Kadena.Chainweb.Mapping do
  @moduledoc """
  Takes a result map or list of maps from Chainweb response and returns a struct
  (e.g. `%Types.LocalResponse{}`) or list of structs.
  """

  @type attr_value :: any()
  @type attr_type ::
          :atom
          | {:map, Keyword.t()}
          | {:struct, module()}
          | {:list, atom(), Keyword.t() | module()}

  @spec build(module :: struct(), attrs :: map()) :: Keyword.t()
  def build(module, attrs) do
    # convert attrs keys to keyword with atom keys
    attrs = Enum.map(attrs, fn {k, v} -> {String.to_existing_atom(k), v} end)

    module
    |> Map.from_struct()
    |> Map.keys()
    |> (&Keyword.take(attrs, &1)).()
  end

  @spec parse(module_attrs :: Keyword.t(), mapping :: Keyword.t()) :: Keyword.t()
  def parse(module_attrs, []), do: module_attrs

  def parse(module_attrs, [{attr, type} | attrs]) do
    value = Keyword.get(module_attrs, attr)
    parsed_value = do_parse(type, value)

    module_attrs
    |> Keyword.put(attr, parsed_value)
    |> parse(attrs)
  end

  @spec do_parse(type :: attr_type(), value :: attr_value()) :: attr_value()
  defp do_parse(:atom, value) when is_binary(value), do: String.to_existing_atom(value)

  defp do_parse({:map, mapping}, value) when is_map(value) do
    Enum.reduce(mapping, value, fn {key, type}, acc ->
      acc
      |> Map.get(key)
      |> (&do_parse(type, &1)).()
      |> (&Map.put(acc, key, &1)).()
    end)
  end

  defp do_parse({:struct, module}, value) when not is_nil(value), do: module.new(value)

  defp do_parse({:list, :map, mapping}, values) when is_list(values) do
    Enum.map(values, &do_parse({:map, mapping}, &1))
  end

  defp do_parse({:list, :struct, module}, values) when is_list(values) do
    Enum.map(values, &module.new(&1))
  end

  defp do_parse(_type, value), do: value
end
