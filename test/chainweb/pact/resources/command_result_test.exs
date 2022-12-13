defmodule Kadena.Chainweb.Pact.Resources.CommandResultTest do
  @moduledoc """
  `CommandResult` struct definition tests.
  """

  use ExUnit.Case

  alias Kadena.Test.Fixtures.Chainweb

  alias Kadena.Types.{Base64Url, ChainID, PactValue, PactValuesList}

  alias Kadena.Chainweb.Pact.Resources.{
    CommandResult,
    Continuation,
    MetaDataResult,
    PactEvent,
    PactEventModule,
    PactEventsList,
    PactExec,
    PactResult,
    Provenance,
    ResponseMetaData,
    Yield
  }

  setup do
    continuation = %PactExec{
      continuation: %Continuation{
        args: %Kadena.Types.PactValue{literal: "pact_value"},
        def: "coin"
      },
      executed: false,
      pact_id: %Kadena.Types.PactTransactionHash{
        hash: "yxM0umrtdcvSUZDc_GSjwadH6ELYFCjOqI59Jzqapi4"
      },
      step: %Kadena.Types.Step{number: 1},
      step_count: 5,
      step_has_rollback: false,
      yield: %Yield{
        data: %{
          "amount" => 0.01,
          "receiver" => "4f9c46df2fe874d7c1b60f68f8440a444dd716e6b2efba8ee141afdd58c993dc",
          "receiver_guard" => %{
            "keys" => ["4f9c46df2fe874d7c1b60f68f8440a444dd716e6b2efba8ee141afdd58c993dc"],
            "pred" => "keys-all"
          },
          "source_chain" => 0
        },
        provenance: %Provenance{
          module_hash: "rE7DU8jlQL9x_MPYuniZJf5ICBTAEHAIFQCB4blofP4",
          target_chain_id: %ChainID{id: "1"}
        }
      }
    }

    events = %PactEventsList{
      pact_events: [
        %PactEvent{
          module: %PactEventModule{name: "coin", namespace: nil},
          module_hash: "rE7DU8jlQL9x_MPYuniZJf5ICBTAEHAIFQCB4blofP4",
          name: "TRANSFER",
          params: %PactValuesList{
            pact_values: [
              %PactValue{literal: "account1"},
              %PactValue{literal: "account2"},
              %PactValue{literal: Decimal.new("0.000050")}
            ]
          }
        }
      ]
    }

    gas = 5
    logs = "wsATyGqckuIvlm89hhd2j4t6RMkCrcwJe_oeCYr7Th8"

    response_meta_data = %ResponseMetaData{
      block_hash: "kZCKTbL3ubONngiGQsJh4fGtP1xrhAoUvcTsqi3uCGg",
      block_height: 2708,
      block_time: 1_656_709_048_955_370,
      prev_block_hash: "LD_o60RB4xnMgLyzkedNV6v-hbCCnx6WXRQy9WDKTgs",
      public_meta: %MetaDataResult{
        chain_id: %ChainID{id: ""},
        creation_time: 0,
        gas_limit: 10,
        gas_price: 0,
        sender: "",
        ttl: 0
      }
    }

    req_key = %Base64Url{url: "uolsidh4DWN-D44FoElnosL8e5-cGCGn_0l2Nct5mq8"}
    result = %PactResult{data: %PactValue{literal: 3}, status: :success}
    tx_id = 123_456

    %{
      attrs: Chainweb.fixture("command_result", to_snake: true),
      continuation: continuation,
      events: events,
      gas: gas,
      logs: logs,
      response_meta_data: response_meta_data,
      req_key: req_key,
      result: result,
      tx_id: tx_id
    }
  end

  test "new/1", %{
    attrs: attrs,
    continuation: continuation,
    events: events,
    gas: gas,
    logs: logs,
    response_meta_data: response_meta_data,
    req_key: req_key,
    result: result,
    tx_id: tx_id
  } do
    %CommandResult{
      continuation: ^continuation,
      events: ^events,
      gas: ^gas,
      logs: ^logs,
      meta_data: ^response_meta_data,
      req_key: ^req_key,
      result: ^result,
      tx_id: ^tx_id
    } = CommandResult.new(attrs)
  end

  test "new/1 with nil tx_id, logs, continuation, meta_data and events", %{
    attrs: attrs,
    gas: gas,
    req_key: req_key,
    result: result
  } do
    attrs = %{
      attrs
      | "tx_id" => nil,
        "logs" => nil,
        "continuation" => nil,
        "meta_data" => nil,
        "events" => nil
    }

    %CommandResult{
      continuation: nil,
      events: nil,
      gas: ^gas,
      logs: nil,
      meta_data: nil,
      req_key: ^req_key,
      result: ^result,
      tx_id: nil
    } = CommandResult.new(attrs)
  end
end
