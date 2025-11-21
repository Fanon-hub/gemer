require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) { attributes_for(:task) }
  let(:invalid_attributes) { { title: "" } }

  describe "GET #index" do
    it "assigns @q and @tasks" do
      task1 = create(:task)
      task2 = create(:task)
      get :index
      expect(assigns(:q)).to be_a(Ransack::Search)
      expect(assigns(:tasks)).to match_array([task1, task2])
    end

    it "searches with Ransack" do
      task = create(:task, title: "Buy milk")
      create(:task, title: "Walk the dog")
      get :index, params: { q: { title_cont: "milk" } }
      expect(assigns(:tasks)).to include(task)
      expect(assigns(:tasks).count).to eq(1)
    end
  end

  describe "GET #show" do
    it "assigns the requested task as @task" do
      task = create(:task)
      get :show, params: { id: task.to_param }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks index" do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid params" do
      it "does not create a new Task" do
        expect {
          post :create, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it "renders new template" do
        post :create, params: { task: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end
end