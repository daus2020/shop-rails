require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 2
  end

  test 'render a details product page' do
    get product_path(products(:ps3))

    assert_response :success
    assert_select '.title', 'PS3 Fat'
    assert_select '.description', 'PS3 one joystick'
    assert_select '.price', 'US$ 95'
  end

  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Nintendo 64',
        description: 'Incompleted cables',
        price: 99
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product successfully created'
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Incompleted cables',
        price: 99
      }
    }

    assert_response :unprocessable_entity
  end

  test 'render an edit product form' do
    get edit_product_path(products(:ps3))

    assert_response :success
    assert_select 'form'
  end

  test 'allows to update a product' do
    patch product_path(products(:ps3)), params: {
      product: {
        price: 95
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product successfully updated'
  end

  test 'does not allow to update a product with invalid field' do
    patch product_path(products(:ps3)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end

  test 'can delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps3))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product was successfuly deleted'
  end
end