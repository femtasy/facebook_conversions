defmodule FacebookConversions.Client do
  @moduledoc """
  Module to provide function to work with the Facebook API client.
  """

  alias FacebookConversions.Config

  @doc """
  Returns a new [Tesla client](`t:Tesla.Client.t/0`).

  The client includes a default list of middlewares:

  * Set the base url
  * Retry any failed request
  * Encode/decode the request/response as JSON

  ## Examples
      iex> #{__MODULE__}.new()
      %Tesla.Client{}
  """
  @spec new() :: Tesla.Client.t()
  def new() do
    middleware = [
      {Tesla.Middleware.BaseUrl, Config.base_url()},
      {Tesla.Middleware.Retry,
       max_retries: 3,
       should_retry: fn
         {:ok, %{status: status}} when status in [400, 500] -> true
         {:ok, _} -> false
         {:error, _} -> true
       end},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end

  @doc """
  Handles a Facebook response.

  https://apidocs.chargebee.com/docs/api#error_handling
  """
  @spec handle_response({:ok, Tesla.Env.result()} | {:error, any}) ::
          {:ok, term} | {:error, Tesla.Env.t()}
  def handle_response(response) do
    case response do
      {:ok, %Tesla.Env{status: status_code, body: response}}
      when status_code >= 200 and status_code <= 299 ->
        {:ok, response}

      {:ok, %Tesla.Env{} = env} ->
        {:error, env}

      {:error, _reason} = error ->
        error
    end
  end
end
