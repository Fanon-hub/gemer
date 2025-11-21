FactoryBot.define do
  factory :task do
    title       { "Test Task #{rand(1..9999)}" }
    description { "This is a sample description for the task." }
    status      { %w[todo doing done].sample }
    deadline    { Date.today + rand(1..30).days }
  end
end