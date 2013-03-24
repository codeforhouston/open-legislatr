class Legislation < ActiveRecord::Base

  has_many :tag_associations
  has_many :tags, :through => :tag_associations
  has_many :events

end