FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    deadline { Time.current }
    state { 'wait' }
    priority { 'low' }
    user
    # after(:build) do |task|
      # label = create(:label)
      # task.labellings << build(:labelling, task: task, label: label)
      # task.labels = FactoryBot.create(:label, name: "仕事")
      # task.labels = FactoryBot.create(:label, name: "趣味")
      # task.labels = FactoryBot.create(:label, name: "家事")
      # create_list(:label, 3, tasks: [task])
    #   create(:labelling, task: task, label: create(:label))
    # end
  end
end
