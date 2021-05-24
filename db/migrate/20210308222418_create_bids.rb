# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true

      t.float :bid_price
      t.float :paid_price

      t.integer :order, default: 0

      t.timestamps
    end
  end
end
