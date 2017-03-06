class Task < ActiveRecord::Base
	validates :description, presence: true, uniqueness: true
	validates :project_id, presence: true
	validates :owner_id, presence: true
	validates :due_at, presence: true

	# Relationship
	belongs_to :project
	belongs_to :user, class_name: "User", foreign_key: "owner_id"
	#belongs_to :user
	#belongs_to :project
end
