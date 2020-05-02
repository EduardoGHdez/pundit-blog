# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :posts }

  describe '#role' do
    let(:user) { create(:user, role: role) }

    context 'when is writer' do
      let(:role) { :writer }
      it { expect(user.writer?).to be true }
    end

    context 'when is moderator' do
      let(:role) { :moderator }
      it { expect(user.moderator?).to be true }
    end
  end
end
