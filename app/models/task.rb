class Task < ActiveRecord::Base
	validates :description, presence: true, uniqueness: true
	validates :project_id, presence: true
	validates :owner_id, presence: true
	validates :due_at, presence: true

	# Relationship
	belongs_to :project
	belongs_to :user, class_name: "User", foreign_key: "owner_id"

	default_value_for :due_at do
		Time.now + 7.days
	end

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

	def current_state
		if incomplete? && (due_at > Time.now)
		  "overdue"
		elsif incomplete? && (due_at <= Time.now)
		  "on-track"
		elsif complete? && (due_at < completed_at)
		  "completed-late"
		else # complete and finished before due date
		  "completed-on-time"
		end
	end
end
