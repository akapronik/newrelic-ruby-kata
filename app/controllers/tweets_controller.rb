class TweetsController < ApplicationController
  def index
    response = HTTParty.get('http://twitter.com/newrelic')
    parsed_data = Nokogiri::HTML.parse response.body
    tweet_nodes = parsed_data.css('.js-tweet-text')
    @nodes = tweet_nodes.collect(&:inner_html)
  end
end
