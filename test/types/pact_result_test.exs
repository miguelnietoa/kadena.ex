defmodule Kadena.Types.PactResultTest do
  @moduledoc """
  `PactResult` struct definition tests.
  """

  use ExUnit.Case

  alias Kadena.Types.{PactResult, PactValue}

  describe "new/1" do
    test "with a valid success status" do
      %PactResult{status: :success, data: %PactValue{literal: 3}} =
        PactResult.new(status: :success, data: 3)
    end

    test "with a valid failure status" do
      %PactResult{status: :failure, data: %{}} = PactResult.new(status: :failure, data: %{})
    end

    test "with a valid PactValue data" do
      pact_value = PactValue.new(3)

      %PactResult{status: :success, data: ^pact_value} =
        PactResult.new(status: :success, data: pact_value)
    end

    test "with an invalid status" do
      {:error, [status: :invalid]} = PactResult.new(status: :complete)
    end

    test "with an invalid success data" do
      {:error, [data: :invalid, literal: :invalid]} =
        PactResult.new(status: :success, data: :success)
    end

    test "with an invalid failure data" do
      {:error, [data: :invalid]} = PactResult.new(status: :failure, data: "invalid_error")
    end

    test "with an invalid arguments match" do
      {:error, [data: :invalid]} = PactResult.new(status: :failure, data: 3)
    end
  end
end
