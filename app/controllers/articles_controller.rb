class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = current_user.articles.find_by_id params[:id]
    if @article.nil?
      @article = Article.find params[:id]
      redirect_to article_transaction_path(@article, :payment_method_token=>current_user.payment_method_token) and return if current_user.payment_method_token
      redirect_to article_payment_method_path(@article) and return
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, :notice => "Successfully created article."
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to @article, :notice  => "Successfully updated article."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url, :notice => "Successfully destroyed article."
  end
end
