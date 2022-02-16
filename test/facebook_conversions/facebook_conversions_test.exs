defmodule FacebookConversionsTest do
  use ExUnit.Case, async: true

  alias FacebookConversions
  alias FacebookConversions.Events.{Event, UserData}

  describe "events/1" do
    test "send the list of events to Facebook" do
      event = %Event{
        event_name: "a facebook event",
        event_time: 23,
        action_source: "system_generated",
        custom_data: %{"ping" => "pong"},
        user_data: %UserData{
          em: ["user_email_hased"],
          client_ip_address: "the ip",
          client_user_agent: "007",
          external_id: ["user_id_hashed"],
          fbc: "facebook campaign",
          fbp: "facebook psomething"
        }
      }

      events = [event]

      Mox.expect(Tesla.MockAdapter, :call, 1, fn %Tesla.Env{url: url, body: body}, _opts ->
        assert url =~ ~r/a_facebook_pixel_id\/events/

        assert %Tesla.Multipart{
                 content_type_params: ["charset=utf-8"],
                 parts: [
                   %Tesla.Multipart.Part{body: ^events, dispositions: [name: "data"]},
                   %Tesla.Multipart.Part{
                     body: "an_access_token",
                     dispositions: [name: "access_token"]
                   }
                 ]
               } = body

        {:ok, %Tesla.Env{status: 200, body: :success}}
      end)

      assert {:ok, :success} = FacebookConversions.send_events(events)
    end
  end
end
