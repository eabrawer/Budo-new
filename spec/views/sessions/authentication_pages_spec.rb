require 'spec_helper'

describe "AuthenticationPages" do

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

			it { should have_link('Profile',      href: user_path(user)) }
			it { should have_content('Sign out') }
			it { should_not have_link('Sign in',  href: signin_path) }			
			it { should have_selector('h1',       text: user.username) }	

			describe "Signing out" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end
	end
end