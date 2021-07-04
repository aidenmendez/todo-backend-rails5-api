require "rails_helper"

describe Todo do
  describe "(happy path)" do
    before do
      Todo.destroy_all
      
      task_params = { :title => "Example 1", :order => 1 }
      post '/todos', {params: task_params}
    end

    it "can create a new task" do
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:title]).to eq("Example 1")
      expect(data[:order]).to eq(1)
      expect(data[:created_at])
      expect(data[:completed]).to eq(false)
    end

    it "can update a task" do
      task = Todo.first
      expect(task.completed).to eq(false)
  
      patch "/todos/#{task.id}", params: { completed: true }
  
      task.reload
  
      expect(task.completed).to eq(true)
    end
  end
end