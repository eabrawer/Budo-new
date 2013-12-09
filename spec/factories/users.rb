# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	username "ericbr"
  	email "eric@something.com"
  	password "eric1234"
  	password_confirmation "eric1234"
  	country "Canada"
  	state "Ontario"
  	city "Toronto"
  	biography "a" * 100
  end
end
