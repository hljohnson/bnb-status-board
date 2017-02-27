class Task < ActiveRecord::Base
	validates :description, presence: true

	# Relationship
	belongs_to :project
	belongs_to :user
	#belongs_to :user
	#belongs_to :project
end
