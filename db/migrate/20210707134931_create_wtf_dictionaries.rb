class CreateWtfDictionaries < ActiveRecord::Migration[6.1]
  def change
    create_table :wtf_dictionaries do |t|
      t.string :word
      t.string :author
      t.string :description

      t.timestamps
    end
  end
end
