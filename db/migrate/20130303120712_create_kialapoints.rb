class CreateKialapoints < ActiveRecord::Migration
  def change
    create_table :kialapoints do |t|
      t.integer :shortkpid
      t.string :kpname
      t.string :street
      t.string :zip
      t.string :city
      t.string :locationhint
      t.string :openinghours
      t.string :label

      t.timestamps
    end
  end
end
