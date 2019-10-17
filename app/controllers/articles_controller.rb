class ArticlesController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @articles = Article.order('id DESC').page(params[:page]).per(3)
  end

  def new
  end

  def create
    Article.create(text: article_params[:text], image: article_params[:image], name: article_params[:name], title: article_params[:title], user_id: current_user.id)
    redirect_to action: :index
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.update(article_params)
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.destroy
    end
  end

  private
  def article_params
    params.permit(:text, :image, :name, :title)
  end

  private
   #ログインしていないとindexページへ
    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end
end
