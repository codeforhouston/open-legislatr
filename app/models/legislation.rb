class Legislation < ActiveRecord::Base

  has_many :tag_associations
  has_many :tags, :through => :tag_associations
  has_many :events

  attr_accessible :bill_id, :source, :identifier_at_source, :session, :state, :chamber,
                  :tags, :events

end