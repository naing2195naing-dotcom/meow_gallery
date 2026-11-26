
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "TestUser",
      email_address: "access-test@example.com",
      password: "Password123!"
    )

    @other_user = User.create!(
      name: "OtherUser",
      email_address: "other-test@example.com",
      password: "Password123!"
    )

    post session_path, params: {
      email_address: @user.email_address,
      password: "Password123!"
    }

    assert_redirected_to root_path
  end

  test "should not edit another user" do
    get edit_user_path(@other_user)

    assert_redirected_to user_path(@user), status: :see_other
  end

  test "should not update another user" do
    patch user_path(@other_user), params: {
      user: { name: "ChangedName" }
    }

    assert_redirected_to user_path(@user), status: :see_other
    assert_equal "OtherUser", @other_user.reload.name
  end

  test "should not destroy another user" do
    assert_no_difference("User.count") do
      delete user_path(@other_user)
    end

    assert_redirected_to user_path(@user), status: :see_other
    assert User.exists?(@other_user.id)
  end
end
