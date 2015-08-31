require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: { name: "", email: "user@invalid",
                               password: "foo", password_confirmation: "bar"}
    end
    assert_template "users/new"
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: { name: "Example User", email: "user@example.com",
                                          password: "foobar", password_confirmation: "foobar"}
    end
    assert_template "users/show"
    assert_not flash.empty?
  end
  
  test "are error messages present" do
    get signup_path
    post_via_redirect users_path, user: { name: "", email: "user@invalid",
                               password: "foo", password_confirmation: "bar"}
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end
  
  
end
