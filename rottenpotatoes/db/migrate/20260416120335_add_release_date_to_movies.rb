class AddReleaseDateToMovies < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :release_date, :date
  end
end
