class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :wtf_entries, :description, :text
  end
end
