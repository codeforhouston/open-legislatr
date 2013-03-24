# This model is for the join table between legislations and tags.
# It has no other purpose and contains no metadata, and is primarily managed
# via built-in operations on ActiveRecord associations.
class TagAssociation < ActiveRecord::Base
  belongs_to :tag
  belongs_to :legislation
end