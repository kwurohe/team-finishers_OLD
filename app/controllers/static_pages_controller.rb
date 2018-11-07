class StaticPagesController < ApplicationController
  def index
  	@games = Game.available
  end
end
