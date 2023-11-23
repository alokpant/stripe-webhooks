class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :stripe_id
      t.string :status, default: 'unpaid'

      t.timestamps
    end
  end
end
