defmodule FacebookConversions do
  @moduledoc """
  Provides access interfaces for the [Facebook Conversions API](https://developers.facebook.com/docs/marketing-api/conversions-api/).

  See [Facebook
  documentation](https://developers.facebook.com/docs/marketing-api/conversions-api/using-the-api)
  for more information about API requests.

  See [Facebook
  documentation](https://developers.facebook.com/docs/marketing-api/app-event-api/app-events-api-for-collaborative-ads)
  for more information about the API events.

  ## Testing

  This library provides a behaviour for each one of the modules of the
  supported resources to implement your own [behaviour
  mocks](https://github.com/dashbitco/mox).
  """

  alias FacebookConversions.Config
  alias FacebookConversions.Client
  alias FacebookConversions.Events.Event

  defmodule Behaviour do
    @moduledoc false

    @callback send_events(list(Event.t()), opts :: keyword()) ::
                {:ok, map} | {:error, Tesla.Env.t()}
  end

  @behaviour __MODULE__.Behaviour

  @doc """
  Sends a list of events to Facebook.

  See [Facebook marketing API
  documentation](https://developers.facebook.com/docs/marketing-api/conversions-api/parameters/server-event).

  ### Options

  * `test_event_code`: Value to send as `test_event_code` in the request. See [testing events documentation](https://www.facebook.com/business/help/1624255387706033) for more details.
  """
  @impl __MODULE__.Behaviour
  def send_events([%Event{} | _] = events, opts \\ []) do
    multipart =
      Tesla.Multipart.new()
      |> Tesla.Multipart.add_content_type_param("charset=utf-8")
      |> Tesla.Multipart.add_field("data", Jason.encode!(events))
      |> Tesla.Multipart.add_field("access_token", Config.access_token())
      |> maybe_add_extra_data(opts)

    Client.new()
    |> Tesla.post("#{Config.pixel_id()}/events", multipart)
    |> Client.handle_response()
  end

  #
  # Private functions
  #

  defp maybe_add_extra_data(%Tesla.Multipart{} = multipart, opts) do
    if Keyword.has_key?(opts, :test_event_code) do
      Tesla.Multipart.add_field(multipart, "test_event_code", opts[:test_event_code])
    else
      multipart
    end
  end
end
