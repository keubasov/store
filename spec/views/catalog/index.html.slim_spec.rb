require 'rails_helper'
require 'database_cleaner'
feature 'catalog/index', type: :view do
  before do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    byaz_look = create(:look, :bedclothe, :unbleached_calico, :adults, name: 'Бязь')
    byaz_image = create(:product_image, :amaretto, look: byaz_look)
    @byaz_product = create(:product, :one_half, look: byaz_look)

    child_look = create(:look, :bedclothe, :unbleached_calico, :childs, name: 'Детское')
    child_image = create(:product_image, :norway, look: child_look)
    @child_product = create(:product, :one_half, look: child_look)

    poplin_look = create(:look, :bedclothe, :poplin, :adults, name: 'Поплин')
    poplin_image = create(:product_image, :amaretto, look: poplin_look)
    @poplin_product = create(:product, :one_half, look: poplin_look)

    sateen_look = create(:look, :bedclothe, :sateen, :adults, name: 'Сатин')
    sateen_image = create(:product_image, :norway, look: sateen_look)
    @sateen_product = create(:product, :one_half, look: sateen_look)
    visit root_path

  end
  scenario 'when visit  root path' do
    expect(page).to have_css('h2', text: 'Бязь')
    expect(page).to have_css('img.center-block')
    expect(page).to have_css('div.catalog_name', text: 'Бязь')
    expect(page).to_not have_css('div.catalog_name', text: 'Детское')
    expect(page).to_not have_css('div.catalog_name', text: 'Сатин')
    expect(page).to_not have_css('div.catalog_name', text: 'Поплин')
    expect(page).to have_css('div.price', text: /.*#{@byaz_product.price}.*/)
    expect(page).to have_css('li#unbleached_calico.active')
  end

  scenario 'when press to child button' do
    click_link('Детское')
    expect(page).to have_css('h2', text: 'Детское')
    expect(page).to have_css('img.center-block')
    expect(page).to_not have_css('div.catalog_name', text: 'Бязь')
    expect(page).to have_css('div.catalog_name', text: 'Детское')
    expect(page).to_not have_css('div.catalog_name', text: 'Сатин')
    expect(page).to_not have_css('div.catalog_name', text: 'Поплин')
    expect(page).to have_css('div.price', text: /.*#{@child_product.price}.*/)
    # expect(page).to have_css('li#child.active')
  end

  scenario 'when press to poplin button' do
    click_link('Поплин')
    expect(page).to have_css('h2', text: 'Поплин')
    expect(page).to have_css('img.center-block')
    expect(page).to_not have_css('div.catalog_name', text: 'Бязь')
    expect(page).to_not have_css('div.catalog_name', text: 'Детское')
    expect(page).to_not have_css('div.catalog_name', text: 'Сатин')
    expect(page).to have_css('div.catalog_name', text: 'Поплин')
    expect(page).to have_css('div.price', text: /.*#{@poplin_product.price}.*/)
    # expect(page).to have_css('li#poplin.active')
  end

  scenario 'when press to sateen button' do
    click_link('Сатин')
    expect(page).to have_css('h2', text: 'Сатин')
    expect(page).to have_css('img.center-block')
    expect(page).to_not have_css('div.catalog_name', text: 'Бязь')
    expect(page).to_not have_css('div.catalog_name', text: 'Детское')
    expect(page).to have_css('div.catalog_name', text: 'Сатин')
    expect(page).to_not have_css('div.catalog_name', text: 'Поплин')
    expect(page).to have_css('div.price', text: /.*#{@sateen_product.price}.*/)
    # expect(page).to have_css('li#sateen.active')
  end
end
