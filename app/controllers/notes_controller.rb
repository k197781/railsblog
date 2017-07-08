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
  	@note = Note.find_by(id: params[:id])
  	REDIS.zincrby "ranking", 1, @note.id
    ids = REDIS.zrevrangebyscore "ranking", "+inf", 0, limit: [0, 5]
    @ranking_articles = ids.map{ |id| Note.find(id) }
    if @ranking_articles.count < 5
      adding_articles = Note.order(updated_at: :DESC).where.not(id: ids).limit(5 - @ranking_articles.count)
      @ranking_articles.concat(adding_articles)
    end
  end

  def edit
  	@note = Note.find_by(id: params[:id])
  end

  def update
  	@note = Note.find_by(id: params[:id])
  	if @note.save
  		redirect_to @note
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Note.find_by(id: params[:id]).destroy
  	redirect_to root_url
  end

  private
  	def note_params
  		params.require(:note).permit(:title, :content)
  	end
end
