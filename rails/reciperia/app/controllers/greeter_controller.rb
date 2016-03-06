class GreeterController < ApplicationController

  def heythere
    bad_names = ['motherfucker', 'asshole', 'bastard', 'sucker']
    @bad_name = bad_names.sample
    @time = Time.now
  end

  def takesome
    curses = ['Fuck you', 'Eat shit', 'Fuck off', 'Go to hell']
    @curse = curses.sample
  end

end
