# require 'spec_helper'

describe "User Pages" do
	subject { page }

	describe "User Show/Profile Page" do
		let(:user) {FactoryGirl.create(:user)}
		before { visit user_path(user.id) }

		it { should have_selector('h1', text: user.username) }
	end

	describe "User New/Signup Page" do
		before { visit new_user_path }
		
# Need to learn to test for valid field inputs
		# describe "With valid information" do
		# 	it "should not create user" do
		# 		old_count = User.count
		# 		click_button "Save account"
		# 		new_count = User.count
		# 		new_count.should == old_count + 1
		# 	end			
		# end

		describe "With invalid information" do
			it "should create user" do
			# expect { click_button "Save account" }.not_to 
			# change(user, :count)	
				old_count = User.count
				click_button "Save account"
				new_count = User.count
				new_count.should == old_count
			end
		end

# Need to learn how to test for redirect
		# describe "After saving a user" do
		# 	before { click_button "Save account" }
		# 	it { should_have selector('h1', text: @user.username) }
		# end

	end
end