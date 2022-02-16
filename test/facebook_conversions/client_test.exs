defmodule FacebookConversions.ClientTest do
  use ExUnit.Case, async: true

  alias FacebookConversions.Client

  describe "new/1" do
    test "returns a new Tesla client" do
      assert %Tesla.Client{
               pre: [
                 {Tesla.Middleware.BaseUrl, _, ["https://test.graph.facebook.com/v13.0/"]},
                 {Tesla.Middleware.Retry, _, _},
                 {Tesla.Middleware.JSON, _, _}
               ]
             } = Client.new()
    end
  end

  describe "handle_response/1" do
    test "returns an ok tuple with the response body when the response status code is 2xx" do
      response = {:ok, %Tesla.Env{status: 200, body: "a response"}}
      assert Client.handle_response(response) == {:ok, "a response"}
    end

    test "returns an error tuple with the `Tesla.Env` when the response status code is different than 2xx" do
      response = {:ok, %Tesla.Env{status: 400, body: "an error"}}

      assert {:error, %Tesla.Env{status: 400, body: "an error"}} =
               Client.handle_response(response)
    end

    test "returns any unexpected error" do
      response = {:error, :unexpected}

      assert {:error, :unexpected} = Client.handle_response(response)
    end
  end
end
