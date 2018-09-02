require 'rails_helper'

RSpec.describe Contributor, type: :model do
  it { should validate_presence_of :position }
  it { should validate_presence_of :username }
  it { should belong_to :search }
end
