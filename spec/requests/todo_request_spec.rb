require "rails_helper"

describe Todo do
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

  it "can return a single task" do
    task = Todo.first

    get "/todos/#{task.id}"

    task_data = JSON.parse(response.body, symbolize_names: true)

    expect(task_data[:title]).to eq("Example 1")
    expect(task_data[:completed]).to be false
    expect(task_data[:order]).to eq(1)
    expect(task_data[:url]).to be_a(String)
  end

  it "can update a task" do
    task = Todo.first
    expect(task.completed).to eq(false)

    patch "/todos/#{task.id}", params: { completed: true }

    task.reload

    expect(task.completed).to eq(true)
  end

  it "can show all tasks" do
    task_params = { :title => "Example 2", :order => 2 }
    
    post '/todos', {params: task_params}

    expect(Todo.count).to eq(2)

    get '/todos'

    tasks_data = JSON.parse(response.body, symbolize_names: true)

    expect(tasks_data.count).to eq(2)
    expect(tasks_data[0][:title]).to eq("Example 1")
    expect(tasks_data[1][:title]).to eq("Example 2")
  end

  it "can delete a single task" do
    task_params = { :title => "Example 2", :order => 2 }
    post '/todos', {params: task_params}

    expect(Todo.count).to eq(2)

    task = Todo.first

    delete "/todos/#{task.id}"
    expect(Todo.count).to eq(1)
  end

  it "can delete all tasks" do
    task_params = { :title => "Example 2", :order => 2 }
    post '/todos', {params: task_params}

    expect(Todo.count).to eq(2)

    delete '/todos'

    expect(Todo.count).to eq(0)
  end

  it "can return all incomplete tasks due today" do
    post '/todos', params: { :title => "Example 2", :order => 2 }
    post '/todos', params: { :title => "Example 3", :order => 3, :completed => true }

    get "/today"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data.count).to eq(2)
    expect(data[0][:title]).to eq("Example 1")
    expect(data[0][:completed]).to be false
    expect(data[0][:due_date]).to eq(Date.today.to_s)
    expect(data[1][:title]).to eq("Example 2")
    expect(data[1][:completed]).to be false
    expect(data[1][:due_date]).to eq(Date.today.to_s)
  end

  it "can return all incomplete tasks due in the future" do
    tomorrow = Date.today + 1

    post '/todos', params: { :title => "Example 2", :order => 2, :due_date => tomorrow }
    post '/todos', params: { :title => "Example 3", :order => 3, :due_date => tomorrow }

    get "/future"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data.count).to eq(2)
    expect(data[0][:title]).to eq('Example 2')
    expect(data[0][:completed]).to be false
    expect(data[0][:due_date]).to eq(tomorrow.to_s)
    expect(data[1][:title]).to eq('Example 3')
    expect(data[1][:completed]).to be false
    expect(data[1][:due_date]).to eq(tomorrow.to_s)
  end

  it "can return all complete and incomplete tasks for today" do
    tomorrow = Date.today + 1

    post '/todos', params: { :title => "Example 2", :order => 2, :completed => true}
    post '/todos', params: { :title => "Example 3", :order => 3, :due_date => tomorrow }

    get "/all_today"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data.count).to eq(2)
    expect(data.first[:title]).to eq("Example 1")
    expect(data[1][:title]).to eq("Example 2")
  end

  it "returns an empty array if there are no tasks to complete today" do
    Todo.destroy_all
    get "/today"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to be_an(Array)
    expect(data.count).to eq(0)
  end

  it "returns an empty array if there are no tasks to complete in the future" do
    Todo.destroy_all
    get "/future"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to be_an(Array)
    expect(data.count).to eq(0)
  end
end