class TagSearchesController < ApplicationController
  before_action :authenticate_user!

  def tag_search
    @model = Book
    @tag = params[:tag]
    @books = Book.where("tag LIKE?","%#{@tag}%")
    render tag_search_path
  end
end
