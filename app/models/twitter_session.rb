require 'launchy'
require 'singleton'

class TwitterSession
  CONSUMER_KEY = "3sXhQUZ1iyVLmvfEMmclhg"
  CONSUMER_SECRET = "30a4p3f4JdcGPGZM7VLAs12WCOPkRXNVwtu01uhKwfQ"
  CONSUMER = OAuth::Consumer.new(
    CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")

  include Singleton

  def initialize
    @access_token = TwitterSession.get_token("./token_file.txt")
  end

  def self.get_token(token_file = "./token_file.txt")
    if File.exist?(token_file)
      File.open(token_file) { |f| YAML.load(f) }
    else
      access_token = self.access_token
      File.open(token_file, "w") { |f| YAML.dump(access_token, f) }

      access_token
    end
  end

  def self.access_token
    if @access_token.nil?
      request_token = CONSUMER.get_request_token
      authorize_url = request_token.authorize_url
      Launchy.open(authorize_url)

      puts "Login, and type your verification code:"
      oauth_verifier = gets.chomp

      @access_token = request_token.get_access_token(
          :oauth_verifier => oauth_verifier
        )
    end

    @access_token
  end

  def get(*args)
    TwitterSession.get_token.get(*args)
  end

  def post(*args)
    TwitterSession.get_token.post(*args)
  end
end