# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :uid
      t.string :nickname
      t.string :image_url
      t.string :fav_streamer_name
      t.string :token
      t.string :refresh_token
    end

    add_index :users, :email,                unique: true
  end
end
