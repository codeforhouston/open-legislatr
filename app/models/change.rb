class Change < ActiveRecord::Base

  belongs_to :event
  belongs_to :legislation, :through => :event

end