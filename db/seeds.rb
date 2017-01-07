require 'rmagick'
include Magick

#Создаем масштабированные копии изображения в целевых директориях
def self.resize_copy(source, destination, new_height)
  img = Image.read(source).first
  height, width = img.rows, img.columns
  new_width = width*new_height.to_f/height
  img.resize_to_fit!(new_width, new_height)
  img.write(destination)
end

Look.delete_all
Product.delete_all
ProductImage.delete_all
images_path = "#{Rails.root}/public/system/product_images/"
FileUtils.rm_rf(images_path)
addr = 'http://www.art-dtex.ru/catalog_bedding_textile.aspx?cat='
links = [7, 8, 19].map{|p| addr+ p.to_s}
links.each_with_index do |link, page_num|
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
      p_image_id = look.product_images.create(image_file_name: name).id
      #Адрес, откуда будем качать картинку
      img_src = "http://www.art-dtex.ru/#{img_link.css('img').last['src']}"

      img_root_path = "#{images_path}/#{p_image_id}/"
      #создаем папки для изображений
      FileUtils.makedirs %w(original medium thumb).map{|dir| "#{img_root_path}#{dir}"}
      #Расширение файла
      f_extension = img_src.split('.').last
      original, medium, thumb = %w(original medium thumb).map{|sz| "#{img_root_path}#{sz}/1.#{f_extension}"}
      # Скачиваем картинку при помощи двух потоков(из OpenUri.read в File.write)
      File.open(original, 'wb'){|file| file.write(open(img_src).read)}

      # создаем копии для разрешений medium и thumb
      resize_copy(original, medium, 200.0)
      resize_copy(original,thumb, 50.0)
      look.products.create(quantity: 1, price: 100, b_size: b_size)

    rescue => e
      p "Не удалось сохранить Look  #{e}"
    end

  end
end

