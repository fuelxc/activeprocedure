# frozen_string_literal: true
class Foo
  attr_accessor :name
end

RSpec.describe ActiveProcedure::ModelConcerns do
  let(:dummy_class) { Class.new do
      include ActiveProcedure::ModelConcerns
      model_class_name "Foo"

      attr_accessor :options
    end
  }

  let(:subject) { dummy_class.new }

  describe '#build_model' do
    it "sets builds a new object of 'model_class_name'" do
      expect(subject.build_model.is_a?(Foo)).to be true
    end

    it "passes in options" do
      subject.options = { name: 'foo bar' }
      expect(subject.build_model.name).to eq('foo bar')
    end
  end
end
