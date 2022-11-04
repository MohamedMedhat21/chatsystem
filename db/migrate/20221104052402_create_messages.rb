class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.string :content
      t.references :chat, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
