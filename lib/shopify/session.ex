defmodule Shopify.Session do
  @moduledoc false

  alias Shopify.{Config, Session}

  defstruct [
    :access_token,
    :api_key,
    :api_version,
    :client_id,
    :client_secret,
    :password,
    :refresh_token,
    :req_opts,
    :shop_name,
    :type
  ]

  @type t :: %__MODULE__{
          access_token: binary() | nil,
          api_key: binary() | nil,
          api_version: binary() | nil,
          client_id: binary() | nil,
          password: binary() | nil,
          refresh_token: binary() | nil,
          req_opts: Keyword.t() | nil,
          shop_name: binary(),
          type: :basic | :oauth
        }

  @spec new(binary, binary, binary) :: Shopify.Session.t()
  def new(shop_name, api_key, password) do
    %Session{
      type: :basic,
      shop_name: Shopify.scrub_shop_name(shop_name),
      api_key: api_key,
      password: password,
      api_version: Config.get(:api_version)
    }
  end

  @spec new(binary, binary) :: Shopify.Session.t()
  def new(shop_name, access_token) do
    %Session{
      type: :oauth,
      shop_name: Shopify.scrub_shop_name(shop_name),
      access_token: access_token,
      api_version: Config.get(:api_version)
    }
  end

  @spec new(binary) :: Shopify.Session.t()
  def new(shop_name) do
    %Session{
      type: :oauth,
      shop_name: Shopify.scrub_shop_name(shop_name),
      client_id: Config.get(:client_id),
      client_secret: Config.get(:client_secret),
      api_version: Config.get(:api_version)
    }
  end

  @spec new() :: Shopify.Session.t()
  def new do
    Config.shop_name()
    |> Shopify.scrub_shop_name()
    |> new(Config.api_key(), Config.password())
  end

  @spec put_api_version(session :: Shopify.Session.t(), api_version :: binary() | nil) ::
          Shopify.Session.t()
  def put_api_version(%Session{} = session, api_version)
      when is_binary(api_version) or is_nil(api_version) do
    %{session | api_version: api_version}
  end

  @spec put_req_opt(session :: Shopify.Session.t(), atom, any) :: Shopify.Session.t()
  def put_req_opt(%Session{} = session, key, value) do
    %{session | req_opts: [{key, value} | session.req_opts || []]}
  end

  @spec put_req_opts(session :: Shopify.Session.t(), req_opts :: Shopify.Request.options()) ::
          Shopify.Session.t()
  def put_req_opts(%Session{} = session, req_opts) when is_list(req_opts) do
    %{session | req_opts: req_opts}
  end
end
