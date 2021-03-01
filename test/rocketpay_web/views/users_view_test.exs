defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  import Phoenix.View

  test "renders create.json" do
    params = %{
      name: "Jose",
      age: 23,
      email: "jose@ajajaj.com",
      password: "123456",
      nickname: "joseahaha"
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)
    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Jose",
        nickname: "joseahaha"
      }
    }

    assert response == expected_response
  end

end
