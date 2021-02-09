class AddUpdatedByToSoftwareFeedbacks < ActiveRecord::Migration[6.0]
  def change
    add_reference :software_feedbacks, :updated_by, foreign_key: {to_table: :users}
  end
end
