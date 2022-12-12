defmodule Kadena.Chainweb.NetworkTest do
  use ExUnit.Case

  alias Kadena.Chainweb.Network

  test "base_url/1 pact testnet04 chain0" do
    "https://api.testnet.chainweb.com/chainweb/0.0/testnet04/chain/0/pact/api/v1" =
      Network.base_url(%{api_type: :pact, network_id: :testnet04, chain_id: 0})
  end

  test "base_url/1 pact mainnet01 chain0" do
    "https://api.chainweb.com/chainweb/0.0/mainnet01/chain/0/pact/api/v1" =
      Network.base_url(%{api_type: :pact, network_id: :mainnet01, chain_id: 0})
  end

  test "base_url/1 p2p testnet04" do
    "https://api.testnet.chainweb.com/chainweb/0.0/testnet04" =
      Network.base_url(%{api_type: :p2p, network_id: :testnet04})
  end

  test "base_url/1 p2p mainnet01" do
    "https://api.chainweb.com/chainweb/0.0/mainnet01" =
      Network.base_url(%{api_type: :p2p, network_id: :mainnet01})
  end

  test "base_url/1 p2p testnet04 chain0" do
    "https://api.testnet.chainweb.com/chainweb/0.0/testnet04/chain/0" =
      Network.base_url(%{api_type: :p2p, network_id: :testnet04, chain_id: 0})
  end

  test "base_url/1 p2p mainnet01 chain0" do
    "https://api.chainweb.com/chainweb/0.0/mainnet01/chain/0" =
      Network.base_url(%{api_type: :p2p, network_id: :mainnet01, chain_id: 0})
  end

  test "base_url/1 with_invalid_api_type" do
    nil = Network.base_url(%{api_type: :invalid, network_id: :testnet04, chain_id: 0})
  end
end
