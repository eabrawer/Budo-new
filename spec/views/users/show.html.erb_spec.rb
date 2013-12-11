# require 'spec_helper'

describe "User Pages" do
	subject { page }

	describe "User Profile Page" do
		subject { page }
		let(:user) {FactoryGirl.create(:user)}
		before { visit user_path(user.id) }

		it { should have_selector('h1', text: user.username) }
	end
	
end