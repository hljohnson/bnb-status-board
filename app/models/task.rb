class Task < ActiveRecord::Base
	validates :description, presence: true, uniqueness: true
	validates :project_id, presence: true
	validates :owner_id, presence: true
	validates :due_at, presence: true

	# Relationship
	belongs_to :project
	belongs_to :user, class_name: "User", foreign_key: "owner_id"

	include AASM
	aasm do
		state :complete
		state :incomplete, :initial => true

		event :mark_complete do
			transitions :from => :incomplete, :to => :complete
		end

		event :mark_incomplete do
			transitions :from => :complete, :to => :incomplete
		end

	end
	
	def other_state
		aasm.states(:permitted => true).map(&:name).first
	end


end
