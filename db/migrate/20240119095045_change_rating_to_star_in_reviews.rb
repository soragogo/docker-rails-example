class ChangeRatingToStarInReviews < ActiveRecord::Migration[7.0]
  def change
    rename_column :reviews, :rating, :star
  end
end
