class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id]) #resourceにしているため:id=> :book_idに変更している
    @favorite = current_user.favorites.new(book_id: @book.id) #引数の中でカラムidと現在選択しているidが一致しているかを確認
    @favorite.save
    #render で直接create.jsを呼び出してもいいが、省略して記述しないときは自動的にcrate.jsを探してくれる
    #いいねした後のページ遷移はどうするの？はcreate.jsでいいね機能の部分だけ更新させている
    #つまり非同期というのは部分的に更新しているもの
  end

  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy

  end

end
