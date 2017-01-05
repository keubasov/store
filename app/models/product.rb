class Product < ApplicationRecord
  belongs_to :look

  validates :quantity,
     # presenсe: true,

            numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :price,
  # presenсe: true,
   numericality: {greater_than_or_equal_to: 0}


  with_options if: "look.product_type == 'bedclothe'" do |bc|
    # bc.validates :b_size, presenсe: true
    # bc.validates :b_material, presenсe: true
  end
  validates :b_size, inclusion: {in: %w(one_half two two_euro euro family)}
  validates :b_material, inclusion: {in: %w(unbleached_calico poplin sateen)}


  # enum product_types: {
  #   bedclothe:    'bedclothe',
  #   blanket:      'blanket',
  #   pillow:       'pillow',
  #   towel:        'towel',
  #   matress:      'matress'
  # }

  # enum bedclothes_size:{
  #   one_half:     'one_half',
  #   two:          'two',
  #   two_euro:     'two_euro',
  #   euro:         'euro',
  #   family:       'family'
  # }

  # enum bedclothes_material:{
  #   unbleached_calico:  'unbleached_calico',
  #   poplin:             'poplin',
  #   sateen:             'sateen'
  # }
#######################################
### Get arrays from enum types     ####
#######################################

  def self.b_materials_for_select
    enum_for_select 'bedclothes_material'
  end
  def self.b_sizes_for_select
    enum_for_select 'bedclothes_size'
  end
#######################################
###  Get array of uniq names       ####
#######################################
def self.names
  Product.all.pluck(:name).uniq
end
#######################################
###           private              ####
#######################################
  private



end
