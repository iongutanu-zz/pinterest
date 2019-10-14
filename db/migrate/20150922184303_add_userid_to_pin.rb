class AddUseridToPin < ActiveRecord::Migration
  def change
      add_column :pins, :user_id, :integer
  end
end
