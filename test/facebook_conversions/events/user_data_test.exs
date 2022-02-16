defmodule FacebookConversions.Events.UserDataTest do
  use ExUnit.Case, async: true

  alias FacebookConversions.Events.UserData

  describe "changeset/1" do
    test "returns a Facebook event" do
      user_data = %{
        "em" => ["user_email_hased"],
        "client_ip_address" => "the ip",
        "client_user_agent" => "007",
        "external_id" => ["user_id_hashed"],
        "fbc" => "facebook campaign",
        "fbp" => "facebook psomething"
      }

      assert %UserData{
               em: ["user_email_hased"],
               client_ip_address: "the ip",
               client_user_agent: "007",
               external_id: ["user_id_hashed"],
               fbc: "facebook campaign",
               fbp: "facebook psomething"
             } = user_data |> UserData.changeset() |> Ecto.Changeset.apply_changes()
    end

    test "validates the data" do
      assert %Ecto.Changeset{valid?: false} = UserData.changeset(%{})
    end
  end
end
