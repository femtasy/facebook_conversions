defmodule FacebookConversions.Events.EventTest do
  use ExUnit.Case, async: true

  alias FacebookConversions.Events.Event
  alias FacebookConversions.Events.UserData

  describe "new/1" do
    test "returns a Facebook event" do
      event_data = %{
        "event_name" => "a facebook event",
        "event_time" => 23,
        "action_source" => "system_generated",
        "custom_data" => %{"ping" => "pong"},
        "user_data" => %{
          "em" => ["user_email_hased"],
          "client_ip_address" => "the ip",
          "client_user_agent" => "007",
          "external_id" => ["user_id_hashed"],
          "fbc" => "facebook campaign",
          "fbp" => "facebook psomething"
        }
      }

      assert {:ok,
              %Event{
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
              }} = Event.new(event_data)
    end

    test "validates the data" do
      event_data = %{
        "event_name" => "a facebook event",
        "event_time" => 23,
        "action_source" => "system_generated",
        "custom_data" => %{"ping" => "pong"},
        "user_data" => %{}
      }

      assert {:error, %Ecto.Changeset{}} = Event.new(event_data)
    end
  end
end
