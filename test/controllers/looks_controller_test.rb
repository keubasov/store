require 'test_helper'

class LooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    agata = 'test/fixtures/files/Agata.jpg'
    @look = look(:bedcl_look)
    @look.product_images.map {|p_i| p_i.image = File.new(agata)}
  end

  test "should get new" do
    get new_look_url
    assert_response :success
    assert_select 'form', minimum: 1
  end

  test "should create look" do
    assert_difference('Look.count') do
      post looks_url, params: { look: {name: 'new_look',
        description: 'new_look', product_type: 'bedclothe'  } }
    end

    assert_redirected_to look_url(Look.last)
  end

  test "should show look" do
    get look_url(@look)
    assert_response :success
    assert_select '#list_image img', minimum: 1
  end

  test "should get edit" do
    get edit_look_url(@look)
    assert_response :success
  end

  test "should update look" do
    patch look_url(@look), params: { look: {name: 'new_look',
        description: 'new_look', product_type: 'bedclothe'   } }
    assert_redirected_to look_url(@look)
  end

  test "should destroy look" do
    assert_difference('Look.count', -1) do
      delete look_url(@look)
    end

    assert_redirected_to looks_url
  end
end
