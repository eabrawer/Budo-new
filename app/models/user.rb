class User < ActiveRecord::Base
	has_secure_password
    	# t.string :username,
    	# t.string :email,
    	# t.string :password_digest,
    	# t.string :picture,
    	# t.string :country,
    	# t.string :state,
    	# t.string :city,	
    	# t.text :biography,

	has_many :martial_arts
	has_many :schools

	validates :username, presence: true, uniqueness: 
		      true, length: { in: 6..15 }

	validates :email, presence: true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
			  uniqueness: { case_sensative: false }

	validates :password, length: { in: 8..12 }

	validates :password_confirmation, presence: true, length: { in: 8..12 }

	validates :biography, length: { in: 100..500 }

	validates :country, :state, :city, presence: true

end
