require 'test_helper'

class ArchitypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @architype = architypes(:one)
  end

  test "should get index" do
    get architypes_url
    assert_response :success
  end

  test "should get new" do
    get new_architype_url
    assert_response :success
  end

  test "should create architype" do
    assert_difference('Architype.count') do
      post architypes_url, params: { architype: { name: @architype.name } }
    end

    assert_redirected_to architype_url(Architype.last)
  end

  test "should show architype" do
    get architype_url(@architype)
    assert_response :success
  end

  test "should get edit" do
    get edit_architype_url(@architype)
    assert_response :success
  end

  test "should update architype" do
    patch architype_url(@architype), params: { architype: { name: @architype.name } }
    assert_redirected_to architype_url(@architype)
  end

  test "should destroy architype" do
    assert_difference('Architype.count', -1) do
      delete architype_url(@architype)
    end

    assert_redirected_to architypes_url
  end
end
