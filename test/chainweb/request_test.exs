defmodule Kadena.Chainweb.Client.CannedRequestImpl do
  @moduledoc false

  @behaviour Kadena.Chainweb.Client.Spec

  @network_url_pact_testnet04_0 "https://api.testnet.chainweb.com/chainweb/0.0/testnet04/chain/0/pact/api/v1"

  @impl true
  def request(
        _method,
        @network_url_pact_testnet04_0 <> "/local",
        _body,
        _headers,
        _opts
      ) do
    send(self(), {:chainweb_requested, 200})
    {:ok, 200, [], nil}
  end
end

defmodule Kadena.Chainweb.RequestTest do
  use ExUnit.Case

  alias Kadena.Chainweb.Error
  alias Kadena.Types.LocalResponse
  alias Kadena.Chainweb.Client.CannedRequestImpl
  alias Kadena.Chainweb.Request

  alias Kadena.Test.Fixtures.Chainweb

  setup do
    Application.put_env(:kadena, :http_client_impl, CannedRequestImpl)

    on_exit(fn ->
      Application.delete_env(:kadena, :http_client_impl)
    end)

    endpoint = "local"
    network_id = :testnet04
    chain_id = "0"

    body =
      "{\"cmd\":\"{\\\"meta\\\":{\\\"chainId\\\":\\\"0\\\",\\\"creationTime\\\":1667249173,\\\"gasLimit\\\":1000,\\\"gasPrice\\\":1.0e-6,\\\"sender\\\":\\\"k:554754f48b16df24b552f6832dda090642ed9658559fef9f3ee1bb4637ea7c94\\\",\\\"ttl\\\":28800},\\\"networkId\\\":\\\"testnet04\\\",\\\"nonce\\\":\\\"2023-06-13 17:45:18.211131 UTC\\\",\\\"payload\\\":{\\\"exec\\\":{\\\"code\\\":\\\"(+ 5 6)\\\",\\\"data\\\":{}}},\\\"signers\\\":[{\\\"addr\\\":\\\"85bef77ea3570387cac57da34938f246c7460dc533a67823f065823e327b2afd\\\",\\\"clist\\\":[{\\\"args\\\":[\\\"85bef77ea3570387cac57da34938f246c7460dc533a67823f065823e327b2afd\\\"],\\\"name\\\":\\\"coin.GAS\\\"}],\\\"pubKey\\\":\\\"85bef77ea3570387cac57da34938f246c7460dc533a67823f065823e327b2afd\\\",\\\"scheme\\\":\\\"ED25519\\\"}]}\",\"hash\":\"-1npoTU2Mi71pKE_oteJiJuHuXTXxoObJm8zzVRK2pk\",\"sigs\":[{\"sig\":\"8b234b83570359e52188cceb301036a2a7b255171e856fd550cac687a946f18fbfc0e769fd8393dda44d6d04c31b531eaf35efb3b78b5e40fd857a743133030d\"}]}"

    headers = [{"Content-Type", "application/json"}]
    query = [query_param1: "value1", query_param2: "value2"]
    params = [params: [:query_param1, :query_param2]]

    %{
      endpoint: endpoint,
      network_id: network_id,
      chain_id: chain_id,
      body: body,
      headers: headers,
      query: query,
      params: params
    }
  end

  test "new/1", %{endpoint: endpoint} do
    %Request{method: :post, endpoint: ^endpoint, body: nil, headers: [], query: []} =
      Request.new(:post, pact: [endpoint: endpoint])
  end

  test "add_body/2", %{endpoint: endpoint, body: body} do
    %Request{method: :post, endpoint: ^endpoint, body: ^body} =
      :post
      |> Request.new(pact: [endpoint: endpoint])
      |> Request.add_body(body)
  end

  test "add_headers/2", %{endpoint: endpoint, headers: headers} do
    %Request{method: :post, endpoint: ^endpoint, headers: ^headers} =
      :post
      |> Request.new(pact: [endpoint: endpoint])
      |> Request.add_headers(headers)
  end

  test "add_query/3", %{endpoint: endpoint, query: query, params: params} do
    %Request{
      method: :post,
      endpoint: ^endpoint,
      query: ^query,
      encoded_query: "query_param1=value1&query_param2=value2"
    } =
      :post
      |> Request.new(pact: [endpoint: endpoint])
      |> Request.add_query(query, params)
  end

  test "add_query/3 invalid_params", %{endpoint: endpoint, query: query} do
    %Request{
      method: :post,
      endpoint: ^endpoint,
      encoded_query: "query_param1=value1"
    } =
      :post
      |> Request.new(pact: [endpoint: endpoint])
      |> Request.add_query(query, params: [:query_param1])
  end

  test "perform/2", %{
    endpoint: endpoint,
    network_id: network_id,
    chain_id: chain_id,
    body: body,
    headers: headers
  } do
    :post
    |> Request.new(pact: [endpoint: endpoint])
    |> Request.set_chain_id(chain_id)
    |> Request.set_network(network_id)
    |> Request.add_body(body)
    |> Request.add_headers(headers)
    |> Request.perform()

    assert_receive({:chainweb_requested, 200})
  end

  test "results/2 success" do
    local_response =
      "local"
      |> Chainweb.fixture()
      |> Jason.decode!()

    {:ok, %LocalResponse{}} = Request.results({:ok, local_response}, as: LocalResponse) |> IO.inspect(label: "RESULT TEST")
  end

  test "results/2 error" do
    {:error, %Error{}} = Request.results({:error, %Error{}}, as: LocalResponse)
  end
end
