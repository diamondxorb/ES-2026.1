class RemoveImageFromMovies < ActiveRecord::Migration[8.1]
  def change
    remove_column :movies, :image, :string
  end
end
