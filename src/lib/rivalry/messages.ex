defmodule Rivalry.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Rivalry.Repo

  alias Rivalry.Messages.Shout

  def send_shout(user, friend) do
    create_shout(%{sender_id: user.id, recipient_id: friend.id})
  end

  @doc """
  Returns the list of shouts.

  ## Examples

      iex> list_shouts()
      [%Shout{}, ...]

  """
  def list_shouts do
    Repo.all(Shout)
  end

  @doc """
  Gets a single shout.

  Raises `Ecto.NoResultsError` if the Shout does not exist.

  ## Examples

      iex> get_shout!(123)
      %Shout{}

      iex> get_shout!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shout!(id), do: Repo.get!(Shout, id)

  @doc """
  Creates a shout.

  ## Examples

      iex> create_shout(%{field: value})
      {:ok, %Shout{}}

      iex> create_shout(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shout(attrs \\ %{}) do
    %Shout{}
    |> Shout.changeset(attrs)
    |> Repo.insert()
  end
end
