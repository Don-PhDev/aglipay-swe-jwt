class AddConstraintToOrders < ActiveRecord::Migration[7.0]
  def up
    execute "ALTER TABLE orders ADD CONSTRAINT quantity_check CHECK (quantity > 0)"
  end

  def down
    execute "ALTER TABLE orders DROP CONSTRAINT quantity_check"
  end
end
