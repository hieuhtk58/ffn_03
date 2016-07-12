class Admin::NewsController < ApplicationController
  before_action :load_news_types, only: [:new, :edit]
  before_action :load_news, only: [:edit, :update]

  def index
    @list_news = News.all
  end

  def new
    @news = current_user.news.build
  end

  def create
    @news = News.new news_params
    if @news.save
      flash[:success] = t ".success"
      redirect_to admin_news_index_path
    else
      load_news_types
      render :new
    end
  end

  def edit
  end

  def update
    if @news.update_attributes news_params
      flash[:success] = t ".success"
      redirect_to admin_news_index_path
    else
      load_news_types
      render :edit
    end
  end

  private
  def news_params
    params.require(:news).permit :title, :news_type_id, :brief_description,
      :represent_image, :content, :author, :user_id
  end

  def load_news_types
    @news_types = NewsType.all.map {|news_type| [news_type.name, news_type.id]}
  end

  def load_news
    @news = News.find_by id: params[:id]
    unless @news
      flash[:danger] = t ".invalid"
      redirect_to admin_news_index_path
    end
  end
end
