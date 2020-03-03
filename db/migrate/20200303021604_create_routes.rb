class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.uuid :provider
      t.float :geo_coordinates
      t.json :response

      t.timestamps
    end
  end
end
