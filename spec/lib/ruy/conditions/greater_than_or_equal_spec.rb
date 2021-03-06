require 'spec_helper'

describe Ruy::Conditions::GreaterThanOrEqual do

  describe '#call' do
    subject(:condition) { Ruy::Conditions::GreaterThanOrEqual.new(18, :age) }

    it 'is true when value is equals' do
      context = Ruy::Context.new({ :age => 18 })

      expect(condition.call(context)).to be
    end

    it 'is true when value is greater' do
      context = Ruy::Context.new({ :age => 19 })

      expect(condition.call(context)).to be
    end

    it 'is false when value is lesser' do
      context = Ruy::Context.new({ :age => 17 })

      expect(condition.call(context)).to_not be
    end
  end

  describe '#==' do
    subject(:condition) { Ruy::Conditions::GreaterThanOrEqual.new(1_000, :salary) }

    context 'when comparing against self' do
      let(:other) { condition }

      it { should eq(other) }
    end

    context 'when same condition values' do
      let(:other) { Ruy::Conditions::GreaterThanOrEqual.new(1_000, :salary) }

      it { should eq(other) }
    end

    context 'when different rule' do
      let(:other) { Ruy::Conditions::All.new }

      it { should_not eq(other) }
    end

    context 'when different values' do
      let(:other) { Ruy::Conditions::GreaterThanOrEqual.new(5, :age) }

      it { should_not eq(other) }
    end
  end
end
