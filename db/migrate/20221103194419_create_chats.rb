class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :messages_count, default: 0
      t.references :application, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
