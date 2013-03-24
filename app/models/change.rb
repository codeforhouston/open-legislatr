class Change < ActiveRecord::Base

  belongs_to :event

  attr_accessible :key, :from, :to, :event

  validates :key,   presence: true
  validates :from,  presence: true
  validates :to,    presence: true

end