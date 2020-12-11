defmodule Myapp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    field :raw_password, :string, virtual: true
    field :raw_password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :raw_password, :raw_password_confirmation])
    |> validate_confirmation(:raw_password, message: "does not match password!")
    |> encrypt_password
    |> validate_required([:name, :email, :raw_password])
  end

  def encrypt_password(%Ecto.Changeset{changes: %{raw_password: raw_password}} = changeset) do
    put_change(changeset, :password, Bcrypt.hash_pwd_salt(raw_password))
  end
  def encrypt_password(changeset) do
    changeset
  end
end
