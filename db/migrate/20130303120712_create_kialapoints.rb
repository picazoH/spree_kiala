class CreateKialapoints < ActiveRecord::Migration
  def up
    create_table :spree_kiala_points do |t|
      t.integer :shortkpid,       :limit => 10,   :null => false
      t.integer :order_id,                       :null => false
      t.string  :kpname,           :limit => 50
      t.string  :street,           :limit => 300
      t.string  :zip,              :limit => 10
      t.string  :city,             :limit => 50
      t.string  :locationhint,     :limit => 4000
      t.string  :openinghours,     :limit => 167
      t.string  :label,            :limit => 30
      t.timestamps
    end
    add_index :spree_kiala_points, :order_id, :name => "index_kialaLS_on_order_id"
  end

  def down
    drop_table :spree_kiala_points
  end
end
