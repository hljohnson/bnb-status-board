class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, uniqueness: true
  validates :last_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

	# Relationships
  has_many :projects
  has_many :tasks
	#has_many :tasks
	#has_and_belongs_to_many :projects
end
