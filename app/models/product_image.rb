class ProductImage < ApplicationRecord
  belongs_to :look
  has_attached_file :image,
    styles: {thumb: "50x50>",  medium: "200x200" },
    default_url:  "/images/:style/:missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def delete_with_file
    begin
      byebug
      FileUtils.remove_dir( File.expand_path('..',File.dirname(image.path))
)
      delete
    rescue
      logger.debug 'Не удалось удалить изображение'
    end
  end
end
