require 'spec_helper'

describe Relationship  do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:Relationship) { follower.Relationship.build(followed_id: followed_id) }
    
  subject { relationship }

  it { should be_valid}


end