defmodule Kadena.Types.ChainwebResponseMetaData do
  @moduledoc """
  `ChainwebResponseMetaData` struct definition.
  """

  alias Kadena.Types.{MetaData, OptionalMetaData}
  alias Kadena.Chainweb.Mapping

  @behaviour Kadena.Types.Spec

  @type hash :: String.t()
  @type block_hash :: hash()
  @type block_number :: number()
  @type block_time :: block_number()
  @type block_height :: block_number()
  @type prev_block_hash :: hash()
  @type public_meta :: OptionalMetaData.t()
  @type value :: hash() | block_number() | public_meta()
  @type validation :: {:ok, value()} | {:error, Keyword.t()}

  @type t :: %__MODULE__{
          block_hash: block_hash(),
          block_time: block_time(),
          block_height: block_height(),
          prev_block_hash: prev_block_hash(),
          public_meta: public_meta()
        }

  defstruct [:block_hash, :block_time, :block_height, :prev_block_hash, :public_meta]

  @mapping [public_meta: {:struct, OptionalMetaData}]

  @impl true
  def new(attrs) do
    %__MODULE__{}
    |> Mapping.build(attrs)
    |> Mapping.parse(@mapping)
  end
end
