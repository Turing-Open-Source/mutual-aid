require 'spec_helper'

RSpec.describe Context do
  describe 'initialization' do
    it 'allows keyword init' do
      context = Context.new user: double(:user)
      expect(context.user).to be_present
    end

    it 'allows args to be omitted' do
      context = Context.new
      expect(context.user).to be_nil
    end
  end

  describe 'custom reader methods' do
    let(:current_settings) { double :current_settings }
    let(:system_setting) { class_double('SystemSetting').as_stubbed_const }
    let(:context) { Context.new }

    example 'can be lazy' do
      expect(context[:system_settings]).to be_nil # not provided during initialization
      expect(system_setting).to receive(:current_settings).and_return current_settings
      expect(context.system_settings).to be current_settings
    end

    example 'can be memoized' do
      expect(system_setting).to receive(:current_settings).once.and_return current_settings
      context.system_settings
      context.system_settings
    end

    example 'can be overriden' do
      expect(system_setting).to receive(:current_settings).never
      context.system_settings = double(:override)
      context.system_settings
    end
  end
end
