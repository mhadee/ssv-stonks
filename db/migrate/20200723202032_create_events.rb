class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :streamer_name
      t.integer :event_type
      t.string :viewer_name
      t.timestamps
    end
  end
end
