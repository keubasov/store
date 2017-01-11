class Look < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :product_images, dependent: :destroy

  validates :name,
    #presenсe: true,
    length: {in: 3..40}
  validates :product_type,
  # presence: true,
            inclusion: {in: %w(bedclothe blanket pillow towel matress), message: 'Недопустимый вид товара'}
  validates :b_material, inclusion: {in: %w(unbleached_calico poplin sateen)}


  #######################################
  ### Get arrays from enum types     ####
  #######################################
  def self.product_types_for_select
    enum_for_select 'product_types'
  end

  def self.b_materials_for_select
    enum_for_select 'bedclothes_material'
  end

  #######################################
  ###  Get array of uniq names       ####
  #######################################
  def self.names
    Look.all.pluck(:name).uniq
  end
end

