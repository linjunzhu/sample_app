require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
end