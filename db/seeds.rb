require 'rmagick'
include Magick

Look.delete_all
Product.delete_all
ProductImage.delete_all
FileUtils.rm_rf( "#{Rails.root}/public/system/product_images/images/000/000")
addr = 'http://www.art-dtex.ru/catalog_bedding_textile.aspx?cat='
links = [6, 7, 8, 19].map{|p|[addr+ p.to_s, p]}
links.each do |link, page_num|
  page = Nokogiri::HTML(open(link))
  case page_num
    when 6
      b_size = 'one_half'
      b_material = 'unbleached_calico'
      childs = true
    when 7
      b_size = 'one_half'
      b_material = 'unbleached_calico'
      childs = false
    when 8
      b_size = 'two'
      b_material = 'unbleached_calico'
      childs = false
    when 19
      b_size = 'one_half'
      b_material = 'poplin'
      childs = false
    else
      b_size = 'one_half'
      b_material = 'unbleached_calico'
      childs = false
  end
  img_links = page.css('div.foto a')
  img_links.each do |img_link|
    begin
      name = img_link.css('span').last.text
      look = Look.find_by_name(name) ||
          Look.create(
            name: name,
            description: name,
            product_type: 'bedclothe',
            b_material: b_material,
            childs: childs)

      #-------------------Адрес, откуда будем качать картинку------------
      img_src = "http://www.art-dtex.ru/#{img_link.css('img').last['src']}"
      #-------------Расширение файла-------------
      f_extension = img_src.split('.').last
      #-------------Временный файл ---------------
      dest = "#{Rails.root}/public/system/#{name}.#{f_extension}"
      IO.copy_stream(open(img_src), dest)
      #--------------Создаем ProductImage--------------
      look.product_images.create(image: File.new(dest))
      #--------------Удаляем временную картинку--------------
      FileUtils.rm_rf(dest)

      #создаем товар
      look.products.create(quantity: 1, price: 100, b_size: b_size)


    rescue => e
      p "Не удалось сохранить Look  #{e}"
    end

  end
end

