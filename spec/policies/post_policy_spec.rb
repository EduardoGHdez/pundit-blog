# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  let(:user) { create(:user, role: role, email: 'test@gmail.com') }
  let(:other_user) { create(:user, email: 'other@gmail.com') }
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

  describe 'Scope' do
    let(:user_posts) { create_list(:post, 10, user: user) }
    let(:published_posts) { create_list(:post, 10, user: other_user) }

    before { create_list(:post, 10, user: other_user) }

    subject(:posts) { PostPolicy::Scope.new(user, Post).resolve }

    context 'when current user has writer role' do
      let(:role) { :writer }

      it 'allows get published Posts and his own Post' do
        permitted_posts = user_posts.count + published_posts.count
        expect(posts.count).to eq(permitted_posts)
      end
    end

    context 'when current user has moderator role' do
      let(:role) { :moderator }

      it 'allows get only published Posts' do
        permitted_posts = Post.all
        expect(posts.count).to eq(permitted_posts.count)
      end
    end
  end
end
