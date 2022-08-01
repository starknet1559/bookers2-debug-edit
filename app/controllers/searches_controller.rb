class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.look(params[:search], params[:word])
    else
      @books = Book.look(params[:search], params[:word])
    end
  end
end
