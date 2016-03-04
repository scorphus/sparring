class GreeterController < ApplicationController

  def heythere
    bad_names = ['motherfucker', 'asshole', 'bastard', 'sucker']
    @bad_name = bad_names.sample
    @time = Time.now
  end

end
