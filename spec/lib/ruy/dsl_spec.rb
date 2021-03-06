require 'spec_helper'

describe Ruy::DSL do
  let(:host) do
    klass = Class.new do
      include Ruy::DSL

      def conditions
        @conditions ||= []
      end
    end

    klass.new
  end

  describe '#all' do
    it 'adds an All condition' do
      host.all {
        between :age, 0, 1
        eq true, :bofh
      }

      expect(host.conditions).to include(be_a(Ruy::Conditions::All))
    end
  end

  describe '#any' do
    it 'adds an Any condition' do
      host.any {
        between :age, 0, 1
        eq true, :bofh
      }

      expect(host.conditions).to include(be_a(Ruy::Conditions::Any))
    end
  end

  describe '#assert' do
    it 'adds an Assert condition' do
      host.assert(:success)

      expect(host.conditions).to include(be_a(Ruy::Conditions::Assert))
    end
  end

  describe '#between' do
    it 'adds a Between condition' do
      host.between(1900, 2000, :year_of_birth)

      expect(host.conditions).to include(be_a(Ruy::Conditions::Between))
    end
  end

  describe '#in_cyclic_order' do
    it 'adds a InCyclicOrder condition' do
      host.in_cyclic_order(23, 5, :work_hours)

      expect(host.conditions).to include(be_a(Ruy::Conditions::InCyclicOrder))
    end
  end

  describe '#cond' do
    it 'adds a Cond condition' do
      host.cond {
        eq 'rule', :rule
      }

      expect(host.conditions).to include(be_a(Ruy::Conditions::Cond))
    end
  end

  describe '#eq' do
    it 'adds an Eq condition' do
      host.eq(:warm, :zone)

      expect(host.conditions).to include(be_a(Ruy::Conditions::Eq))
    end
  end

  describe '#except' do
    it 'adds an Except condition' do
      host.except

      expect(host.conditions).to include(be_a(Ruy::Conditions::Except))
    end
  end

  describe '#greater_than' do
    it 'adds a GreaterThan condition' do
      host.greater_than(18, :age)

      expect(host.conditions).to include(be_a(Ruy::Conditions::GreaterThan))
    end
  end

  describe '#greater_than_or_equal' do
    it 'adds a GreaterThanOrEqual condition' do
      host.greater_than_or_equal(18, :age)

      expect(host.conditions).to include(be_a(Ruy::Conditions::GreaterThanOrEqual))
    end
  end

  describe '#in' do
    it 'adds an In condition' do
      host.in([:white, :blue, :red], :color)

      expect(host.conditions).to include(be_a(Ruy::Conditions::In))
    end
  end

  describe '#include' do
    it 'adds an Include condition' do
      host.include(:colors, :white)

      expect(host.conditions).to include(be_a(Ruy::Conditions::Include))
    end
  end

  describe '#less_than_or_equal' do
    it 'adds a LessThanOrEqual condition' do
      host.less_than_or_equal(17, :age)

      expect(host.conditions).to include(be_a(Ruy::Conditions::LessThanOrEqual))
    end
  end

  describe '#less_than' do
    it 'adds a LessThan condition' do
      host.less_than(18, :age)

      expect(host.conditions).to include(be_a(Ruy::Conditions::LessThan))
    end
  end

  describe '#tz' do
    it 'adds a TZ condition' do
      host.tz {
        between '2014-12-31T23:00:00', '2015-01-01T01:00:00', :timestamp
        eq '2015-01-01T00:00:00', :timestamp
        all do
          eq 18, :age
        end
      }

      expect(host.conditions).to include(be_a(Ruy::Conditions::TZ))
    end
  end

end
