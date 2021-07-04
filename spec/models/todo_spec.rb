require 'rails_helper'

describe Todo do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_fields(:title, :order, :url, :completed, :due_date) }
end