require 'rails_helper'

RSpec.describe 'full_title', type: :helper do
  include ApplicationHelper
  it 'return full title' do
    expect(full_title(nil)).to eq 'BIGBAG Store'
    expect(full_title(' ')).to eq 'BIGBAG Store'
    expect(full_title('page_title')).to eq 'page_title - BIGBAG Store'
  end
end
