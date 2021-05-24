# frozen_string_literal: true

class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :notes
      t.string :status
      t.float :price
      t.integer :count, default: 1

      t.timestamps
    end
  end
end
