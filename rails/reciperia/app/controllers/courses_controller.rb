class CoursesController < ApplicationController

  def index
    @search_term = params[:q] || 'julia'
    @courses = Course.for(@search_term)
  end

end
