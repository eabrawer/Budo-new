require 'spec_helper'

describe User do
	before { @user = FactoryGirl.create(:user) }

	subject { @user }

	it "should respond to attributes" do
		@user.should respond_to(:username)
		@user.should respond_to(:email)
		@user.should respond_to(:password_digest)
		@user.should respond_to(:password)
		@user.should respond_to(:password_confirmation)				
		@user.should respond_to(:picture)
		@user.should respond_to(:country)
		@user.should respond_to(:state)
		@user.should respond_to(:city)	
		@user.should respond_to(:biography)	
		@user.should respond_to(:remember_token)					
	end

	it "should only allow biography and picture to be empty" do
		@user.username.should_not be_empty
		@user.email.should_not be_empty
		@user.password.should_not be_empty
		@user.password_confirmation.should_not be_empty
		@user.country.should_not be_empty		
		@user.state.should_not be_empty
		@user.city.should_not be_empty	
		@user.should be_valid 
	end

		describe "When name is not present" do
			before { @user.username = " " }
			it { should_not be_valid }
		end

		describe "when username is too long" do
			before {@user.username = "a" * 20}
			it { should_not be_valid }
		end

		describe "When email is not present" do
			before {@user.email = " "}
			it { should_not be_valid }
		end

# need to learn how to validate email

		describe "When email address is already taken" do
			before do 
				@user2 = @user.dup 
				@user2.email = @user.email.upcase
				@user2.save
			end
			it "should not be valid" do
				@user2.should_not be_valid
			end
		end

		describe "When password is not present" do
			before do
				@user.password = @user.password_confirmation
				@user.password_confirmation = " "
			end
			it { should_not be_valid }
		end

		describe "When password does not match confirmation" do
			before {@user.password_confirmation = 
					'mismatch'}
			it { should_not be_valid }
		end

		describe "When password does not match confirmation" do
			before {@user.password_confirmation = nil}
			it { should_not be_valid }
		end

		describe "When password is too long or short" do
			before do 
				@user.password = @user.password_confirmation
				@user.password_confirmation = "a" * 7
			end
			it { should_not be_valid }
		end

		describe "When desrciption is too long or short" do
			before {@user.biography = "a" * 99}
			it { should_not be_valid }
		end

		describe "When address info is not present" do
			before do
				@user.country = " "
				@user.state = " "
				@user.city = " "
			end
			it { should_not be_valid }
		end

		# describe "remember token" do
		# 	before { @user.save }
		# 	# its(:remember_token) { should_not be_blank }
		# 	it "should have a nonblank remember token" do
		# 		subject.remember_token.should_not be_blank
		# 	end
		# end
end
