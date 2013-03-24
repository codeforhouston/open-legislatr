class Event < ActiveRecord::Base

  belongs_to  :legislation
  has_many    :changes

  attr_accessible :changes, :legislation, :published

  accepts_nested_attributes_for :changes

  validates_associated :changes

end