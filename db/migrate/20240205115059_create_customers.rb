class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.boolean :vip
      t.integer :days_to_pay
      t.string :gender

      t.timestamps
    end
  end
end
