class CreateWtfEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :wtf_entries do |t|
      t.string :word
      t.string :author
      t.string :description

      t.timestamps
    end
    add_index :wtf_entries, :word, unique: true
  end
end
