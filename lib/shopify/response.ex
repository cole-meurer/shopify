defmodule Shopify.Response do
  @moduledoc false

  @type t :: %__MODULE__{code: integer, data: map | list(map)}

  alias Shopify.Errors

  defstruct [
    :code,
    :data,
    :headers
  ]

  def new(%{body: body, code: code, headers: headers}, resource) when code < 300 do
    {:ok, %__MODULE__{code: code, data: resource |> parse_json(body), headers: headers}}
  end

  def new(%{body: body, code: code, headers: headers}, error) do
    {:error, %__MODULE__{code: code, data: error |> parse_json(body), headers: headers}}
  end

  defp parse_json(_res, body) when is_nil(body) or body == "" do
    nil
  end

  defp parse_json(resource, body) do
    case Poison.decode(body, as: resource) do
      {:ok, %Shopify.OAuth{} = oauth} -> oauth
      {:ok, resource} -> parse_resource(resource)
      {:error, _} -> nil
    end
  end

  defp parse_resource(resource)
  defp parse_resource(%{__struct__: _} = resource), do: resource
  defp parse_resource(resource), do: resource |> Map.values() |> List.first()

  def check_for_errors!({:ok, %__MODULE__{} = response}) do
    {:ok, response}
  end

  def check_for_errors!({:error, %__MODULE__{code: 429, data: data} = response}) do
    raise Errors.ExcessUsageError, message: data, response: response
  end

  def check_for_errors!({:error, %__MODULE__{code: code, data: data} = response}) do
    raise Errors.ResponseError, message: "#{code} - #{data}", response: response
  end
end
