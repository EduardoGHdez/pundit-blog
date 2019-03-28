# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  let(:user) { create(:user, role: role) }
  let(:post) { create(:post, user: user) }

  subject { PostPolicy.new(user, post) }

  context 'when user has writer role' do
    let(:role) { :writer }

    it { should authorize(:create) }

    context 'when the current user is the post owner' do
      it { should authorize(:edit) }
      it { should authorize(:destroy) }
    end

    context 'when the current user is not the post owner' do
      let(:other_user) { create :user }
      let(:post) { create(:post, user: other_user) }

      it { should_not authorize(:edit) }
      it { should_not authorize(:destroy) }
    end
  end

  context 'when user has moderator role' do
    let(:role) { :moderator }

    it { should_not authorize(:create) }
    it { should_not authorize(:edit) }
    it { should_not authorize(:destroy) }
  end
end
