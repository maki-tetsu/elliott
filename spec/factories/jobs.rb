# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
      code "MyString"
      name "MyString"
      description "MyString"
      customer "MyString"
      due_date "2011-11-15"
      start_date "2011-11-15"
      end_date "2011-11-15"
      budget "9.99"
      estimate_submitted_date "2011-11-15"
      register_id 1
      register_name "MyString"
      registed_at "2011-11-15 20:18:54"
      note "MyText"
    end
end