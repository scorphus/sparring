class RecipesController < ApplicationController

  def index
    @search_term = params[:q] || ''
    @recipes = Recipe.for(@search_term)
  end

end
