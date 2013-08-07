class Follow < ActiveRecord::Base
  attr_accessible :stalker_id, :prey_id

  belongs_to :stalker,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :stalker_id

  belongs_to :prey,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :prey_id


end
