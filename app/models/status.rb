class Status < ActiveRecord::Base
  attr_accessible :body, :author_id, :created_at

  belongs_to :user,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :author_id


  def self.parse_twitter_status(json)
    statuses = []
    json.each do |tweet|
      status = {}
      status[:body] = tweet["text"]
      status[:created_at] = tweet["created_at"]
      status[:author_id] = tweet["user"]["id"]
      statuses << status
    end
    statuses
  end
end
