class ChangeStarTypeToIntegerInReviews < ActiveRecord::Migration[6.0]
  def up
    # 'star'カラムの値をintegerにキャストするためのSQLを実行
    execute 'ALTER TABLE reviews ALTER COLUMN star TYPE integer USING (star::integer)'
  end

  def down
    # ロールバックの場合、'star'カラムを再びstringに変更
    change_column :reviews, :star, :string
  end
end
