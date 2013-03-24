class Event < ActiveRecord::Base

  belongs_to  :legislation
  has_many    :changes

  accepts_nested_attributes_for :changes

  validates_associated :changes

end