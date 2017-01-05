# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Look.delete_all
  Product.delete_all
  ProductImage.delete_all
  FileUtils.rm_rf(Rails.root.join('public', 'system', 'product_images').to_s)
  main_page = Nokogiri::HTML(open('http://www.art-dtex.ru/catalog-artpostel.aspx'))
  links = main_page.css('#submenu1 ul li a')
  links.each do |link|
    page = Nokogiri::HTML(open('http://www.art-dtex.ru' + link.value))
    page_name = page.css('div.content div.text_content h1').text
  end
