
# "Add" + [table whose id we want to add] + "To" + [table we want to add the foreign key to]
class AddTopicToPosts < ActiveRecord::Migration
  def change
    # adds a topic_id column to the posts table.
    add_column :posts, :topic_id, :integer
    #index the foreign keys column
    add_index :posts, :topic_id
  end
end
