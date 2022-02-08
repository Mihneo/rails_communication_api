class AddMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
