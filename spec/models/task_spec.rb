
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(todo: 0, doing: 1, done: 2) }
  end

  it "is valid with valid attributes" do
    task = build(:task)
    expect(task).to be_valid
  end

  it "is not valid without a title" do
    task = build(:task, title: nil)
    expect(task).to be_invalid
    expect(task.errors[:title]).to include("can't be blank")
  end
end