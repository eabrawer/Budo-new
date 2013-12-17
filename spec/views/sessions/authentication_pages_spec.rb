require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin path" do
		before { visit signin_path }

		it { should have_content('Sign in') }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button 'Sign in'}

			it { should have_content('Sign in') }
			it { should have_content('not') }
		end

		describe "with valid information" do
			let(:user) {FactoryGirl.create(:user)}
			
			before do
				fill_in "email", 	with: user.email
				fill_in "password", with: user.password
				click_button "Sign in"
			end

			it { should have_link('Profile',       href: user_path(user)) }
			it { should have_link('Settings',      href: edit_user_path(user)) }
			it { should have_content('Sign out') }
			it { should_not have_link('Sign in',   href: signin_path) }			
			it { should have_selector('h1',        text: user.username) }	

			describe "Signing out" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end
	end
end

describe "Authorization" do

	subject { page }

	describe "for non-signed_in users" do
		let(:user) { FactoryGirl.create(:user) }

		describe "when attempting to visit a protected page" do
			before do
				visit edit_user_path(user)
				fill_in "Email", :with => user.email
				fill_in "password", :with => user.password
				click_button "Sign in"
			end

			describe "after signing in" do
				before { visit edit_user_path(user) }
				it "should render the desired protected page" do
					page.should have_content("User Edit")
				end
			end
		end

		describe "in the users controller" do

			describe "visiting the edit page" do
				before { visit edit_user_path(user) }
				it { should have_content('Please sign in')}
			end

			# describe "submitting to the update action" do
			# 	before { put user_path(user) }
			# 	specify { response.should redirect_to(signin_path) }
			# end

			# for when the landing page is not user index
			# describe "visiting the index page" do
			# 	before { visit users_url }
			# 	it { should have_content()}
			# end
		end
	end

	describe "as wrong user" do
		let(:user) { FactoryGirl.create(:user) }
		let(:wrong_user) { FactoryGirl.create(:user, :email => "wrong@example.com", :username => "badname") }	
		
		before do
			visit signin_path
			fill_in "Email", :with => user.email
			fill_in "password", :with => user.password
			click_button "Sign in"
		end

		describe "visiting user#edit page" do
			before { visit edit_user_path(wrong_user) }

			it { should_not have_content("Sign in") }
		end

		# describe "submitting a PUT request to the Users#update action" do
			# before { put user_path(wrong_user) }
			# specify { response.should redirect_to(users_url) }
		# end


	end
end




