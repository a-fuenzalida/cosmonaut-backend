class ChangeImageColumnToUser < ActiveRecord::Migration[5.2]
  def up
    rename_column :users, :image, :picture
  end

  def down
    rename_column :users, :image, :image
  end
end
