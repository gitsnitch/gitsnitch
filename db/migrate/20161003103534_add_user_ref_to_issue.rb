class AddUserRefToIssue < ActiveRecord::Migration[5.0]
  def change
    add_reference :issues, :user, foreign_key: true
  end
end
