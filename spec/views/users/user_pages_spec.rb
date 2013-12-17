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

			describe "after saving a user" do
				before {click_button submit }

				let(:user) { User.find_vy_email("user@example.com") }

				it { should have_content ("successfully") }
				it { should have_link ("Sign out") }
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

	describe 'User Edit Page' do
		let(:user) { FactoryGirl.create(:user) }

		before do 
			visit signin_path
			fill_in "Email", :with => user.email
			fill_in "password", :with => user.password
			click_button "Sign in"
			visit edit_user_path(user) 
		end

		describe "page" do
			it { should have_selector('h1', text: 'User Edit') }
		end

		describe "with invalid information" do
			before { click_button "Save account" }

			it { should have_content("error") }
		end

		describe "with valid information" do
			let(:new_name) { "New Name" }
			let(:new_email) { "new@gmail.com" }

			before do
				fill_in 'Enter username', 				  with: new_name
				fill_in 'Enter your email', 			  with: new_email
				fill_in 'Enter password', 				  with: user.password
				fill_in 'Repeat password', 				  with: user.password
				click_button "Save account"
			end

			it { should have_content("New Name") }
			it { should have_content("updated") }
			specify { user.reload.username.should == new_name }
			specify { user.reload.email.should == new_email }
		end
	end
end