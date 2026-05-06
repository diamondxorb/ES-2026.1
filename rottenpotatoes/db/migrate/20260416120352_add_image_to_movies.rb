class AddImageToMovies < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :image, :string
  end
end
