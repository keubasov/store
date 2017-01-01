class ProductImage < ApplicationRecord
  belongs_to :product
  has_attached_file :image, styles: { medium: "300x300>", thumb: "50x50>" }, :path => ":rails_root/public/images/:id/:filename", url:  "/images/:id/:filename"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
