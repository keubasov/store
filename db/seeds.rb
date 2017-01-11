require 'rmagick'
include Magick


Look.delete_all
Product.delete_all
ProductImage.delete_all
images_path = "#{Rails.root}/public/system/product_images/images/000/000"
FileUtils.rm_rf(images_path)
addr = 'http://www.art-dtex.ru/catalog_bedding_textile.aspx?cat='
links = [7, 8, 19].map{|p|[addr+ p.to_s, p]}
links.each do |link, page_num|
  page = Nokogiri::HTML(open(link))
  case page_num
    when 7
      b_size = 'one_half'
      b_material = 'unbleached_calico'
    when 8
      b_size = 'two'
      b_material = 'unbleached_calico'
    when 19
      b_size = 'one_half'
      b_material = 'poplin'
    else
      b_size = 'one_half'
      b_material = 'unbleached_calico'
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
            b_material: b_material)

      #-------------------Адрес, откуда будем качать картинку------------
      img_src = "http://www.art-dtex.ru/#{img_link.css('img').last['src']}"

      #-------------Расширение файла-------------
      f_extension = img_src.split('.').last
      p_image_id = look.product_images.create(image_file_name: "#{name}.#{f_extension}").id
      img_root_path = "#{images_path}/#{sprintf("%3.3d",p_image_id)}/"

      img = Image.read(img_src).first
      [['original', 0], ['medium', 200.0], ['thumb',50.0]].each do |dir, new_height|
        #-----------создаем папки для изображений-------------
        FileUtils.makedirs "#{img_root_path}#{dir}"

        #----------Объект, содержащий изображение---------
        unless new_height == 0

        #-------------Масштабируем изображения-------
          height, width = img.rows, img.columns
          new_width = width*new_height.to_f/height
          img.resize_to_fit!(new_width, new_height)
        end
        #---------------  Сохраняем Image в файл  ------------
        img.write("#{img_root_path}#{dir}/#{name}.#{f_extension}")
        #----------Заполняем поля для ProductImage---------
        look.product_images.first.update(
            image_content_type: "image/#{img.format}",
            image_file_size: img.filesize,
            image_updated_at: DateTime.now)
      end
      img.destroy!


      #создаем товар
      look.products.create(quantity: 1, price: 100, b_size: b_size)


    rescue => e
      p "Не удалось сохранить Look  #{e}"
    end

  end
end

