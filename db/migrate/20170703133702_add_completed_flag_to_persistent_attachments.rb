class AddCompletedFlagToPersistentAttachments < ActiveRecord::Migration
  def change
    add_column :persistent_attachments, :completed_at, :datetime
  end
end
