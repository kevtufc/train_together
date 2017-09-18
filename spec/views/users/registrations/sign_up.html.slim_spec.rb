require 'rails_helper'

RSpec.describe "users/registrations/new.html.slim", type: :view do

  let(:fields) { %w[name email password password_confirmation] }

  before do
    view.singleton_class.class_eval do
      def resource
        User.new
      end

      def resource_name
        'user'
      end

      def devise_mapping
        Devise.mappings[:user]
      end
    end
  end

  it 'shows the sign up form' do
    render
    fields.each do |field|
      expect(rendered).to have_css("#user_#{field}")
    end
  end
end
