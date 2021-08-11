defmodule Shopify.RecurringApplicationCharge do
  @derive[Poison.Encoder]
  @singular "recurring_application_charge"
  @plural "recurring_application_charges"

  use Shopify.Resource,
    import: [
      :find,
      :all,
      :create,
      :delete
    ]

  alias Shopify.{
    Client,
    Request,
    RecurringApplicationCharge
  }

  defstruct [
    :activated_on,
    :billing_on,
    :cancelled_on,
    :capped_amount,
    :confirmation_url,
    :created_at,
    :id,
    :name,
    :price,
    :return_url,
    :status,
    :terms,
    :test,
    :trial_days,
    :trial_ends_on,
    :updated_at
  ]

  @doc false
  def empty_resource do
    %RecurringApplicationCharge{}
  end

  @doc false
  def find_url(id), do: @plural <> "/#{id}.json"

  @doc false
  def all_url, do: @plural <> ".json"

  @doc false
  def activate_url(id), do: @plural <> "/#{id}/activate.json"
end
