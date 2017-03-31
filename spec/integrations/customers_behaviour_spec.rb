require 'rails_helper'

feature 'users behaviors', js: true do
  before do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    byaz_look = create(:look, :bedclothe, :unbleached_calico, :adults, name: 'Бязь')
    byaz_image = create(:product_image, :amaretto, look: byaz_look)
    @byaz_product = create(:product, :one_half, look: byaz_look)
  end

  scenario 'user buys a product' do
    visit root_path
    # Пользователь добавляет товар в корзину два раза
    expect(page).to have_css('span.cart_quantity', text: '0')
    click_link("#{I18n.t @byaz_product.b_size}#{@byaz_product.price} руб.")
    expect(page).to have_css('span.cart_quantity', text: '1')
    click_link("#{I18n.t @byaz_product.b_size}#{@byaz_product.price} руб.")
    expect(page).to have_css('span.cart_quantity', text: '2')
    # Пользователь заходит в корзину и видит 2 товара
    click_link('моей корзине')
    expect(page).to have_content(I18n.t @byaz_product.b_size)
    expect(page).to have_css('td', text: '2')
    expect(page).to have_css('button', text: 'Заказать')
  end
end
