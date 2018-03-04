class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.integer :rating
      t.string :comment
      t.integer :ratable_id
      t.string :ratable_type

      t.timestamps
    end
  end
end
