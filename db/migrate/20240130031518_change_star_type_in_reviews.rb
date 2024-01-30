class ChangeStarTypeInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :star, :string
  end
end
