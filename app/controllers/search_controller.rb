class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token

  def live_search
    @results = SearchSafeHaven.new(params[:q]).call
    render layout: false
  end
end
