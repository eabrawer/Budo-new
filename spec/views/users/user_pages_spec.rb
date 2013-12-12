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

		let(:submit) { "Save account"}
		
		describe "With invalid information" do

			it "should not create user" do
			expect { click_button submit }.not_to change(User, :count)	
			end

			describe "after submission" do
				before { click_button submit }
				it { should have_content('error')}
			end

		end

		describe "With valid information" do

			before do
				fill_in 'Enter username', with: "helloladies"
				fill_in 'Enter your email', with: "example@gmail.com"
				fill_in 'Enter password', with: "hello1234"
				fill_in 'Repeat password', with: "hello1234"
				fill_in 'Enter your country', with: "Canada"
				fill_in 'Enter your state', with: "Onatrio"
				fill_in 'Enter your city', with: "Toronto"
				fill_in 'Write something about yourself', with: "a" * 101
			end

			it "should create user" do
				expect { click_button submit }.to change(User, :count).by(1)					
			end	

			# To test the flash just check for selector that
			# is unique to the flash

		end



# Need to learn how to test for redirect
		# describe "After saving a user" do
		# 	before { click_button "Save account" }
		# 	it { should_have selector('h1', text: @user.username) }
		# end

	end
end