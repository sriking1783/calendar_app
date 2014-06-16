require 'test_helper'

class CalendarSettingsControllerTest < ActionController::TestCase
  setup do
    @calendar_setting = calendar_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calendar_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calendar_setting" do
    assert_difference('CalendarSetting.count') do
      post :create, calendar_setting: { default_view: @calendar_setting.default_view, popup_time: @calendar_setting.popup_time }
    end

    assert_redirected_to calendar_setting_path(assigns(:calendar_setting))
  end

  test "should show calendar_setting" do
    get :show, id: @calendar_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calendar_setting
    assert_response :success
  end

  test "should update calendar_setting" do
    patch :update, id: @calendar_setting, calendar_setting: { default_view: @calendar_setting.default_view, popup_time: @calendar_setting.popup_time }
    assert_redirected_to calendar_setting_path(assigns(:calendar_setting))
  end

  test "should destroy calendar_setting" do
    assert_difference('CalendarSetting.count', -1) do
      delete :destroy, id: @calendar_setting
    end

    assert_redirected_to calendar_settings_path
  end
end
