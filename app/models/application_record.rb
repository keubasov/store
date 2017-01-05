class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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
