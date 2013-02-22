require 'test_helper'

class ColleaguesControllerTest < ActionController::TestCase
  setup do
    @colleague = colleagues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colleagues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create colleague" do
    assert_difference('Colleague.count') do
      post :create, colleague: { location: @colleague.location, name: @colleague.name, project: @colleague.project }
    end

    assert_redirected_to colleague_path(assigns(:colleague))
  end

  test "should show colleague" do
    get :show, id: @colleague
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @colleague
    assert_response :success
  end

  test "should update colleague" do
    put :update, id: @colleague, colleague: { location: @colleague.location, name: @colleague.name, project: @colleague.project }
    assert_redirected_to colleague_path(assigns(:colleague))
  end

  test "should destroy colleague" do
    assert_difference('Colleague.count', -1) do
      delete :destroy, id: @colleague
    end

    assert_redirected_to colleagues_path
  end
end
