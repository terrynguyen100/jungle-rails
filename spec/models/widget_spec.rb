require 'rails_helper'

# calling #id means calling an instance method of the widget model
# start a new test-group with `describe`
describe '#id' do
  it 'should not exist for new records' do
    @widget = Widget.new
    expect(@widget.id).to be_nil 
  end

  it 'should be auto-assigned by AR for saved records' do
    @widget = Widget.new

    @widget.save!

    expect(@widget.id).to be_present
  end
end
