defmodule Shopify.ApplicationCharge do
  @derive [Poison.Encoder]
  @singular "application_charge"
  @plural "application_charges"

  use Shopify.Resource,
    import: [
      :find,
      :all,
      :create,
      :activate
    ]

  alias Shopify.{
    ApplicationCharge
  }

  defstruct [
    :confirmation_url,
    :created_at,
    :id,
    :name,
    :price,
    :return_url,
    :status,
    :test,
    :updated_at
  ]

  @doc false
  def empty_resource do
    %ApplicationCharge{}
  end

  @doc false
  def find_url(id), do: @plural <> "/#{id}.json"

  @doc false
  def all_url, do: @plural <> ".json"

  @doc false
  def activate_url(id), do: @plural <> "/#{id}/activate.json"
end
