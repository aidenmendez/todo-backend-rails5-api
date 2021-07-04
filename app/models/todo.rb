class Todo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :url, type: String
  field :completed, type: Boolean, default: false
  field :order, type: Integer
  field :due_date, type: Date, default: Date.today

end