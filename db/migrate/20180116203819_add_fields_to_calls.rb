class AddFieldsToCalls < ActiveRecord::Migration[5.1]
  def change
    add_column :calls, :to, :string
    add_column :calls, :from, :string
    add_column :calls, :end_time, :timestamp
    add_column :calls, :voicemail_url, :text
    add_column :calls, :call_sid, :string
    add_column :calls, :status, :string
    add_column :calls, :duration, :integer
    add_index :calls, :call_sid
  end
end
