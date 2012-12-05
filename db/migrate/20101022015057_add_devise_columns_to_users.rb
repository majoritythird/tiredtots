class AddDeviseColumnsToUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
    create_table :users do |t|
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
    create_table :users do |t|
      t.string :email
    end
  end
end
