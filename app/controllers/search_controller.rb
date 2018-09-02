class SearchController < ApplicationController
  before_action :load_new_search, only: [:new, :show, :create]
  before_action :load_search, only: :show

  def new; end

  def show
    respond_with @search
  end

  def create
    respond_with(@search = Search.create(search_params), location: -> { search_path })
  end

  private

  def load_new_search
    @new_search = Search.new
  end

  def load_search
    @search = Search.last
  end

  def search_params
    params.require(:search).permit(:url)
  end
end
