class CreateInitialModels < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer :legislation_id
      t.boolean :published
      t.timestamps
    end

    create_table :changes do |t|
      t.integer :event_id
      t.string :key
      t.string :from
      t.string :to
      t.string :human
      t.timestamps
    end

    create_table :legislations do |t|
      t.string  :bill_id
      t.string  :source
      t.string  :identifier_at_source
      t.string  :session
      t.string  :state
      t.string  :chamber
      t.timestamps
    end

    create_table :tag_associations do |t|
      t.integer :legislation_id
      t.integer :tag_id
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :events
    drop_table :changes
    drop_table :legislations
    drop_table :tag_associations
    drop_table :tags
  end
end
