class Project < ActiveRecord::Base
	default_scope { order(created_at: :desc) }

	validates :name, presence: true, uniqueness: true

	# Relationships
	has_many :tasks
	belongs_to :user, class_name: "User", foreign_key: "owner_id"
	has_many :users, -> { distinct }, through: :tasks

	include AASM
	aasm do
		state :on_track, :initial => true
		state :at_risk
		state :in_trouble
		state :in_maintenance
		state :waiting_on_client

		event :set_on_track do
			transitions :to => :on_track
		end

		event :set_at_risk do
			transitions :to => :at_risk
		end

		event :set_in_trouble do
			transitions :to => :in_trouble
		end

		event :set_in_maintenance do
			transitions :to => :in_maintenance
		end

		event :set_waiting_on_client do
			transitions :to => :waiting_on_client
		end

	end

	def current_state
		aasm_state.humanize.parameterize
	end


end
