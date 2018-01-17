class AddVoiceResponse < ActiveRecord::Migration[5.1]
  def change
    create_table :voice_responses do |t|
      t.string :name
      t.text :xml
      t.index :name
      t.timestamps
    end
  end
end
