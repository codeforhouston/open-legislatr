class Tag < ActiveRecord::Base

  has_many :tag_associations
  has_many :legislations, :through => :tag_associations

end