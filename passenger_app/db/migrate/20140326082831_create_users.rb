class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone_number
      t.string :auth_token

      t.timestamps
    end
  end
end
