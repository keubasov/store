require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    agata = 'test/fixtures/files/Agata.jpg'
    @product = products(:bedcl)
    # @product_name.product_images.map {|p_i| p_i.image = File.new(agata)}
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select '#products-table.row img', 1
  end

  # test "should get new" do
  #   get new_product_url
  #   assert_response :success
  # end

  # test "should create product" do
  #   assert_difference('Product.count') do
  #     post products_url, params: { product: {name: 'bedclothe2', price: @product.price, quantity: @product.quantity, description: @product.description, product_type: @product.product_type, b_size: @product.b_size, b_material: @product.b_material} }
  #   end
  #   assert_redirected_to product_url(Product.last)
  # end

  # test "should show product" do
  #   get product_url(@product)
  #   assert_response :success
  #   assert_select '#list_image img', minimum: 1
  # end

  # test "should get edit" do
  #   get edit_product_url(@product)
  #   assert_response :success
  # end

  # test "should update product" do
  #   patch product_url(@product), params: { product: {name: @product.name, price: @product.price, quantity: @product.quantity, description: @product.description, product_type: @product.product_type, b_size: @product.b_size, b_material: @product.b_material} }
  #   assert_redirected_to product_url(@product)
  # end

  # test "should destroy product" do
  #   assert_difference('Product.count', -1) do
  #     delete product_url(@product)
  #   end
  #   assert_redirected_to products_url
  # end
end
