class User < ActiveRecord::Base
  attr_accessible :id, :username
  #users that are following me
  has_many :stalkers,
    :through => :follows,
    :source => :stalker
    #statuses he posted
  has_many :statuses,
    :class_name => "Status",
    :primary_key => :id,
    :foreign_key => :author_id
    #acts of following performed ON me
  has_many :follows,
    :class_name => "Follow",
    :primary_key => :id,
    :foreign_key => :prey_id
    #acts of following performed BY me
  has_many :stalks,
    :class_name => "Follow",
    :primary_key => :id,
    :foreign_key => :stalker_id
    #users that I am following
  has_many :preys,
    :through => :stalks,
    :source => :prey
    #statuses of users I am following
  has_many :followed_statuses,
    :through => :preys,
    :source => :statuses

  def sync_statuses
    result = TwitterSession.instance.
      get("https://api.twitter.com/1.1/statuses/user_timeline.json").body
    tweets = Status.parse_twitter_status(JSON.parse(result))
    tweets.each do |tweet|
      Status.create!(tweet)
    end
  end








end
