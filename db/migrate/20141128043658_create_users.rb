class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :group_id
      t.string :name
      t.integer :worker_num
      t.string :password_digest
      t.string :remember_token
      t.boolean :admin

      t.timestamps
    end
  end
end
