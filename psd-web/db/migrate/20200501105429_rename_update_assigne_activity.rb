# rubocop:disable Rails/ApplicationRecord
class Activity < ActiveRecord::Base; end
# rubocop:enable Rails/ApplicationRecord

class RenameUpdateAssigneActivity < ActiveRecord::Migration[5.2]
  def up
    Activity.where(type: "AuditActivity::Investigation::UpdateAssignee").update_all(type: "AuditActivity::Investigation::UpdateOwner")
  end

  def down
    Activity.where(type: "AuditActivity::Investigation::UpdateOwner").update_all(type: "AuditActivity::Investigation::UpdateAssignee")
  end
end
