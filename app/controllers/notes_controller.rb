class NotesController < ApplicationController
  def new
  	@note = Note.new
  end

  def create
  	@note = Note.new(note_params)
  	if @note.save
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def show
  	@note = Note.find_by(params[:id])
  end

  def edit
  	@note = Note.find_by(params[:id])
  end

  def update
  	@note = Note.find_by(params[:id])
  	if @note.save
  		redirect_to @note
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Note.find_by(params[:id]).destroy
  	redirect_to root_url
  end

  private
  	def note_params
  		params.require(:note).permit(:title, :content)
  	end
end
