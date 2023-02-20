class AddConstraintToOrders < ActiveRecord::Migration[7.0]
  def up
    execute "ALTER TABLE orders ADD CONSTRAINT price_check CHECK (quantity < 0)"
  end

  def down
    execute "ALTER TABLE orders DROP CONSTRAINT price_check"
  end
end
