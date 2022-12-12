defmodule Kadena.Chainweb.Network do
  @moduledoc """
  Utility that handles Chainweb network URL resolution.
  """

  @type api_type :: :pact | :p2p
  @type opts :: map()

  @base_urls [
    testnet04: "https://api.testnet.chainweb.com/chainweb/0.0/testnet04",
    mainnet01: "https://api.chainweb.com/chainweb/0.0/mainnet01"
  ]

  @spec base_url(opts :: opts()) :: String.t() | nil
  def base_url(%{api_type: :pact, network_id: network_id, chain_id: chain_id}) do
    "#{@base_urls[network_id]}/chain/#{chain_id}/pact/api/v1"
  end

  def base_url(%{api_type: :p2p, network_id: network_id, chain_id: chain_id}) do
    "#{@base_urls[network_id]}/chain/#{chain_id}"
  end

  def base_url(%{api_type: :p2p, network_id: network_id}) do
    @base_urls[network_id]
  end

  def base_url(_opts), do: nil
end
