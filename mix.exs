defmodule Kadena.MixProject do
  use Mix.Project

  @version "0.8.0"
  @github_url "https://github.com/kommitters/kadena.ex"

  def project do
    [
      app: :kadena,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Kadena",
      description: description(),
      source_url: @github_url,
      package: package(),
      docs: docs(),
      dialyzer: [
        plt_add_apps: [:kadena, :ex_unit, :jason],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:hackney, :logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:blake2, "~> 1.0.4"},
      {:decimal, "~> 2.0"},
      {:hackney, "~> 1.18"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:excoveralls, "~> 0.15", only: :test}
    ]
  end

  defp description do
    """
    Elixir library to interact with the Kadena blockchain.
    """
  end

  defp package do
    [
      description: description(),
      files: ["lib", "config", "mix.exs", "README*", "LICENSE"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@github_url}/blob/master/CHANGELOG.md",
        "GitHub" => @github_url,
        "Sponsor" => "https://github.com/sponsors/kommitters"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      name: "Kadena.ex",
      source_ref: "v#{@version}",
      source_url: @github_url,
      canonical: "https://hexdocs.pm/kadena",
      extras: extras(),
      groups_for_modules: groups_for_modules()
    ]
  end

  defp groups_for_modules do
    [
      "Building Commands": [
        Kadena.Pact.Command,
        Kadena.Pact.ExecCommand
      ],
      "Kadena Chainweb": [
        Kadena.Chainweb.Client,
        Kadena.Chainweb.Error,
        Kadena.Chainweb.Client.Default,
        Kadena.Chainweb.Client.Spec,
        Kadena.Chainweb.Pact.Request,
        Kadena.Chainweb.Pact.JSONPayload
      ],
      Cryptography: [
        Kadena.Cryptography.Sign,
        Kadena.Cryptography.KeyPair,
        Kadena.Cryptography.Utils,
        Kadena.Cryptography.KeyPair,
        Kadena.Cryptography.KeyPair.Spec,
        Kadena.Cryptography.KeyPair.Default,
        Kadena.Cryptography.Sign,
        Kadena.Cryptography.Sign.Spec,
        Kadena.Cryptography.Sign.Default
      ],
      Types: [
        Kadena.Types.Base16String,
        Kadena.Types.Base64Url,
        Kadena.Types.Base64UrlsList,
        Kadena.Types.Cap,
        Kadena.Types.CapsList,
        Kadena.Types.ChainID,
        Kadena.Types.ChainwebResponseMetaData,
        Kadena.Types.Command,
        Kadena.Types.CommandPayload,
        Kadena.Types.CommandResult,
        Kadena.Types.CommandsList,
        Kadena.Types.ContPayload,
        Kadena.Types.Continuation,
        Kadena.Types.EnvData,
        Kadena.Types.ExecPayload,
        Kadena.Types.KeyPair,
        Kadena.Types.ListenRequestBody,
        Kadena.Types.ListenResponse,
        Kadena.Types.LocalRequestBody,
        Kadena.Types.LocalResponse,
        Kadena.Types.MetaData,
        Kadena.Types.NetworkID,
        Kadena.Types.OptionalCapsList,
        Kadena.Types.OptionalMetaData,
        Kadena.Types.OptionalPactEventsList,
        Kadena.Types.PactCode,
        Kadena.Types.PactDecimal,
        Kadena.Types.PactEvent,
        Kadena.Types.PactEventModule,
        Kadena.Types.PactEventsList,
        Kadena.Types.PactExec,
        Kadena.Types.PactInt,
        Kadena.Types.PactPayload,
        Kadena.Types.PactResult,
        Kadena.Types.PactTransactionHash,
        Kadena.Types.PactValue,
        Kadena.Types.PactValuesList,
        Kadena.Types.PollRequestBody,
        Kadena.Types.PollResponse,
        Kadena.Types.Proof,
        Kadena.Types.Provenance,
        Kadena.Types.Rollback,
        Kadena.Types.SendRequestBody,
        Kadena.Types.SendResponse,
        Kadena.Types.SignCommand,
        Kadena.Types.SignatureWithHash,
        Kadena.Types.Signature,
        Kadena.Types.SignaturesList,
        Kadena.Types.SignedCommand,
        Kadena.Types.Signer,
        Kadena.Types.SignersList,
        Kadena.Types.SigningCap,
        Kadena.Types.Spec,
        Kadena.Types.SPVProof,
        Kadena.Types.SPVRequestBody,
        Kadena.Types.SPVResponse,
        Kadena.Types.Step,
        Kadena.Types.Yield
      ],
      Utils: Kadena.Utils.MapCase
    ]
  end

  defp extras() do
    [
      "README.md",
      "CHANGELOG.md",
      "CONTRIBUTING.md"
    ]
  end
end
