class AddFlagPublishedToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_active, :boolean, default: true
  end
end
