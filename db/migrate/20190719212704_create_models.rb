class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :context
      t.integer :number
      t.integer :user_id
    end
  end
end
