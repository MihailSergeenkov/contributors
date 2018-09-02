class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.integer :position, default: 0
      t.string :username
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
