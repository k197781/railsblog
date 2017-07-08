class StaticPagesController < ApplicationController
  def home
  	@notes = Note.all
  end
end
