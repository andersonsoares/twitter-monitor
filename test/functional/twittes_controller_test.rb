require 'test_helper'

class TwittesControllerTest < ActionController::TestCase
  setup do
    @twitte = twittes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twittes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitte" do
    assert_difference('Twitte.count') do
      post :create, twitte: { date: @twitte.date, from_user: @twitte.from_user, from_user_id_str: @twitte.from_user_id_str, id_str: @twitte.id_str, keyword_id: @twitte.keyword_id, profile_image_url: @twitte.profile_image_url, text: @twitte.text }
    end

    assert_redirected_to twitte_path(assigns(:twitte))
  end

  test "should show twitte" do
    get :show, id: @twitte
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitte
    assert_response :success
  end

  test "should update twitte" do
    put :update, id: @twitte, twitte: { date: @twitte.date, from_user: @twitte.from_user, from_user_id_str: @twitte.from_user_id_str, id_str: @twitte.id_str, keyword_id: @twitte.keyword_id, profile_image_url: @twitte.profile_image_url, text: @twitte.text }
    assert_redirected_to twitte_path(assigns(:twitte))
  end

  test "should destroy twitte" do
    assert_difference('Twitte.count', -1) do
      delete :destroy, id: @twitte
    end

    assert_redirected_to twittes_path
  end
end
