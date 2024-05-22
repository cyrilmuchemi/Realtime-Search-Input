class CreateSearchQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :search_queries do |t|
      t.string :query
      t.string :ip_address
      t.string :user_identifier

      t.timestamps
    end
  end
end
