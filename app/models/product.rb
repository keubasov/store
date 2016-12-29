class Product < ApplicationRecord

  has_many :product_images, dependent: :destroy

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
  def self.product_types_for_select
    enum_for_select 'product_types'
  end
  def self.b_materials_for_select
    enum_for_select 'bedclothes_material'
  end
  def self.b_sizes_for_select
    enum_for_select 'bedclothes_size'
  end
#######################################
###           private              ####
#######################################
  private

###########################################################
###   Get array of arrays of  option for select         ###
### with his  translations. The method require          ###
###  translations of options for default locale         ###
###########################################################
  def self.enum_for_select(enumerator)
    enum_to_ary(enumerator).map{|item| [I18n.t(item), item.to_sym]}
  end


###########################################################
###           Get array from enum type                  ###
###########################################################
  def self.enum_to_ary(enumerator)
    ary = ActiveRecord::Base.connection.execute("select enum_range(null::#{enumerator});")
    ary = ary[0]['enum_range'][1..-2].split(',')
  end

end
