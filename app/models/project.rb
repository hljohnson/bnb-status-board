class Project < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	# Relationships
	has_many :tasks
	belongs_to :user
	#has_and_belongs_to_many :users
	#has_many :tasks
	# has_one :owner ???
end
