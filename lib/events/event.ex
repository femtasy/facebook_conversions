defmodule FacebookConversions.Events.Event do
  @derive Jason.Encoder

  @doc """
  Represents a Facebook ad event.

  See the [Facebook marketing API
  documentation](https://developers.facebook.com/docs/marketing-api/conversions-api/parameters/server-event)
  for more information.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias FacebookConversions.Events.UserData

  @typedoc """
  Information required for a Facebook event:

  * `user_data`: Information about the user.
  * `custom_data`: Optional map with any extra information.
  """
  @type t :: %__MODULE__{}

  @required_params [
    :event_name,
    :event_time,
    :action_source
  ]

  @optional_params [
    :custom_data
  ]

  @primary_key false
  embedded_schema do
    field(:event_name, :string)
    field(:event_time, :integer)
    field(:action_source, :string)
    field(:custom_data, :map, null: true)

    embeds_one(:user_data, UserData)
  end

  @spec new(%__MODULE__{}, map()) :: {:ok, __MODULE__.t()} | {:error, Ecto.Changeset.t()}
  def new(%__MODULE__{} = changeset \\ %__MODULE__{}, attrs) do
    attrs = Map.put(attrs, "action_source", "system_generated")

    changeset
    |> cast(attrs, @required_params ++ @optional_params)
    |> cast_embed(:user_data)
    |> validate_required(@required_params)
    |> apply_action(:update)
  end
end
