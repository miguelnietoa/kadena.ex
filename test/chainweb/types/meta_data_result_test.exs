defmodule Kadena.Chainweb.Resources.MetaDataResultTest do
  @moduledoc """
  `MetaDataResultTest` struct definition tests.
  """

  use ExUnit.Case

  alias Kadena.Types.ChainID
  alias Kadena.Chainweb.Resources.MetaDataResult

  setup do
    %{
      attrs: %{
        "chain_id" => "0",
        "creation_time" => 0,
        "gas_limit" => 10,
        "gas_price" => 0,
        "sender" => "",
        "ttl" => 0
      }
    }
  end

  test "new/1", %{attrs: attrs} do
    %MetaDataResult{
      chain_id: %ChainID{id: "0"},
      creation_time: 0,
      gas_limit: 10,
      gas_price: 0,
      sender: "",
      ttl: 0
    } = MetaDataResult.new(attrs)
  end
end
