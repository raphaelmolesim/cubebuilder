require 'test_helper'

class CubesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cube = cubes(:one)
  end

  test "should get index" do
    get cubes_url
    assert_response :success
  end

  test "should get new" do
    get new_cube_url
    assert_response :success
  end

  test "should create cube" do
    assert_difference('Cube.count') do
      post cubes_url, params: { cube: { name: @cube.name, password: @cube.password } }
    end

    assert_redirected_to cube_url(Cube.last)
  end

  test "should show cube" do
    get cube_url(@cube)
    assert_response :success
  end

  test "should get edit" do
    get edit_cube_url(@cube)
    assert_response :success
  end

  test "should update cube" do
    patch cube_url(@cube), params: { cube: { name: @cube.name, password: @cube.password } }
    assert_redirected_to cube_url(@cube)
  end

  test "should destroy cube" do
    assert_difference('Cube.count', -1) do
      delete cube_url(@cube)
    end

    assert_redirected_to cubes_url
  end
end
