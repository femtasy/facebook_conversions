defmodule FacebookConversions.Config do
  @moduledoc """
  Context module for configuration.
  """

  @doc """
  Returns the `base_url` to be used on Facebook API calls.
  """
  @spec base_url() :: String.t()
  def base_url() do
    Application.get_env(:facebook_conversions, :base_url)
  end

  @doc """
  Returns the configured Facebook pixel id.
  """
  @spec pixel_id() :: String.t()
  def pixel_id() do
    Application.get_env(:facebook_conversions, :pixel_id)
  end

  @doc """
  Returns the Facebook access token.
  """
  @spec access_token() :: String.t()
  def access_token() do
    Application.get_env(:facebook_conversions, :access_token)
  end
end
