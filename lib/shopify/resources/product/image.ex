defmodule Shopify.Product.Image do
  @derive [Poison.Encoder]
  @singular "image"
  @plural "images"

  use Shopify.NestedResource,
    import: [
      :find,
      :all,
      :count,
      :create,
      :update,
      :delete
    ]

  defstruct [
    :alt,
    :created_at,
    :id,
    :metafields,
    :position,
    :product_id,
    :src,
    :updated_at,
    :variant_ids
  ]

  @doc false
  def empty_resource do
    %__MODULE__{}
  end

  @doc false
  def find_url(top_id, nest_id) do
    "products/#{top_id}/" <> @plural <> "/#{nest_id}.json"
  end

  @doc false
  def all_url(top_id), do: "products/#{top_id}/" <> @plural <> ".json"

  @doc false
  def count_url(top_id), do: "products/#{top_id}/" <> @plural <> "/count.json"
end
