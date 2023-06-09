class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    if params[:fav]
      @books = Book.all.sort_by {|x| x.favorites.count}.reverse
    else
      @books = Book.all.order(params[:sort])
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, book_id: @book.id)
      current_user.read_counts.create(book_id: @book.id)
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(',')
    if @book.save
      @book.save_tags(tag_list)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:tag_name].split(',')
    if @book.update(book_params)
      @book.save_tags(tag_list)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
