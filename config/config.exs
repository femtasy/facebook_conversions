import Config

config :facebook_conversions,
  access_token: "an_access_token",
  base_url: "https://test.graph.facebook.com/v13.0/",
  pixel_id: "a_facebook_pixel_id"

config :tesla, adapter: Tesla.MockAdapter
