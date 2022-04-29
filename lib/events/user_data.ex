defmodule FacebookConversions.Events.UserData do
  @derive Jason.Encoder

  @moduledoc """
  Represents user information of a Facebook user.

  See the [Facebook marketing API
  documentation](https://developers.facebook.com/docs/marketing-api/conversions-api/parameters/customer-information-parameters#formatting-the-user-data-parameters)
  for more information.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @typedoc """
  User information for a Facebook event:

  * `em`: List of user emails hashed with SHA256
  * `external_id`: List of user ids hashed with SHA256
  """
  @type t :: Ecto.Changeset.t()

  @required_params [
    :em,
    :client_ip_address,
    :client_user_agent,
    :external_id
  ]

  @optional_params [
    :fbc,
    :fbp
  ]

  @primary_key false
  embedded_schema do
    field(:em, {:array, :string})
    field(:client_ip_address, :string)
    field(:client_user_agent, :string)
    field(:external_id, {:array, :string})
    field(:fbc, :string)
    field(:fbp, :string)
  end

  @spec changeset(%__MODULE__{}, map()) :: __MODULE__.t()
  def changeset(%__MODULE__{} = changeset \\ %__MODULE__{}, attrs) do
    changeset
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end
end
