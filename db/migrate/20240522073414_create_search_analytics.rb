class CreateSearchAnalytics < ActiveRecord::Migration[6.1]
  def change
    create_table :search_analytics do |t|
      t.string :query
      t.integer :count

      t.timestamps
    end
  end
end
