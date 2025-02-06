class WikiPagesController < ApplicationController
  before_action :set_wiki_page, only: [:show, :edit, :update, :destroy]

  def index
    @wiki_pages = WikiPage.order(title: :asc)
  end

  def show
  end

  def new
    @wiki_page = current_user.wiki_pages.build
  end

  def edit
  end

  def create
    @wiki_page = current_user.wiki_pages.build(wiki_page_params)
    if @wiki_page.save
      redirect_to @wiki_page, notice: 'Wiki page was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @wiki_page.update(wiki_page_params)
      redirect_to @wiki_page, notice: 'Wiki page was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @wiki_page.destroy
    redirect_to wiki_pages_url, notice: 'Wiki page was successfully deleted.'
  end

  def search
    @wiki_pages = WikiPage.where("title LIKE ?", "%#{params[:q]}%")
    render :index
  end

  private

  def set_wiki_page
    @wiki_page = WikiPage.find(params[:id])
  end

  def wiki_page_params
    params.require(:wiki_page).permit(:title, :content)
  end
end 