FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    deadline { Time.current }
    state { 'wait' }
    priority { 'low' }
  end
end
