class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :fragment
      t.string :url
      t.string :raw

      t.timestamps
    end
  end
end
