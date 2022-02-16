defmodule FacebookConversions do
  @moduledoc """
  Provides access interfaces for the [Facebook Conversions API](https://developers.facebook.com/docs/marketing-api/conversions-api/).

  See [Facebook
  documentation](https://developers.facebook.com/docs/marketing-api/conversions-api/using-the-api)
  for more information about API requests.

  See [Facebook
  documentation](https://developers.facebook.com/docs/marketing-api/app-event-api/app-events-api-for-collaborative-ads)
  for more information about the API events.
  """

  alias FacebookConversions.Config
  alias FacebookConversions.Client
  alias FacebookConversions.Events.Event

  @doc """
  Sends a list of events to Facebook.

  See [Facebook marketing API
  documentation](https://developers.facebook.com/docs/marketing-api/conversions-api/parameters/server-event).
  """
  @spec send_events(list(Event.t())) :: {:ok, map} | {:error, Tesla.Env.t()}
  def send_events([%Event{} | _] = events) do
    multipart =
      Tesla.Multipart.new()
      |> Tesla.Multipart.add_content_type_param("charset=utf-8")
      |> Tesla.Multipart.add_field("data", events)
      |> Tesla.Multipart.add_field("access_token", Config.access_token())

    Client.new()
    |> Tesla.post("#{Config.pixel_id()}/events", multipart)
    |> Client.handle_response()
  end
end
