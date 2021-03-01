defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      user_params = %{
        name: "Jose",
        age: 23,
        email: "jose@ajajaj.com",
        password: "123456",
        nickname: "joseahaha"
      }
      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(user_params)

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5QG1heGF1dG9tYWNhby5jb20uYnI6QG1AeDA1MDM5NkA=")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Ballence changed successfully"} = response
    end

    test "when there are invalid params , retorn an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "alo"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid value!"}

      assert response == expected_response
    end
  end

  describe "withdraw/2" do
    setup %{conn: conn} do
      user_params = %{
        name: "Jose",
        age: 23,
        email: "jose@ajajaj.com",
        password: "123456",
        nickname: "joseahaha"
      }
      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(user_params)

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5QG1heGF1dG9tYWNhby5jb20uYnI6QG1AeDA1MDM5NkA=")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))

      response = conn
      |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "0.00", "id" => _id},
        "message" => "Ballence changed successfully"} = response
    end

    test "when there are invalid params , retorn an error", %{conn: conn, account_id: account_id} do



      params = %{"value" => "alo"}

      response = conn
      |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
      |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid value!"}

      assert response == expected_response
    end
  end
end
