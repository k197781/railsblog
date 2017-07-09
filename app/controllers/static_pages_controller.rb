class StaticPagesController < ApplicationController
  def home
  	@notes = Note.all
  	#ids = REDIS.zrevrangebyscore "ranking", "+inf", 0, limit: [0, 5]
  	#@ranking_articles = ids.map{ |id| Note.find(id) }
    #if @ranking_articles.count < 5
    #  adding_articles = Note.order(updated_at: :DESC).where.not(id: ids).limit(5 - @ranking_articles.count)
    #  @ranking_articles.concat(adding_articles)
    #end
  end
end
