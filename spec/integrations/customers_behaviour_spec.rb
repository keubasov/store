require 'rails_helper'

feature 'users behaviors' do
  before do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    byaz_look = create(:look, :bedclothe, :unbleached_calico, :adults, name: 'Бязь')
    byaz_image = create(:product_image, :amaretto, look: byaz_look)
    @byaz_product = create(:product, :one_half, look: byaz_look)
  end

  scenario 'user buys a product' do
    visit root_path
    expect(page).to have_css('div#catalog_name', text: 'Бязь')
    find('a.product_link').click
    expect(page).to have_css('div.carousel-inner')
    expect(page).to have_css('.row.buy')
    find('.row.buy').click

  end
end
