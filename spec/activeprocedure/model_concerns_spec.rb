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
      expect(Foo).to receive(:new).with(name: 'foo bar')
      subject.build_model
    end
  end

  describe '#validate_model!' do
    let(:model) { double }
    it "returns true if valid" do
      expect(model).to receive(:valid?).and_return(true)
      expect(subject).to receive(:model).and_return(model)

      expect(subject.validate_model!).to be true
    end

    it "raises if not valid" do
      expect(model).to receive(:valid?).and_return(false)
      expect(subject).to receive(:model).and_return(model)

      expect{subject.validate_model!}.to raise_error(ActiveProcedure::InvalidModelError)
    end
  end

  describe '#save_model!' do
    let(:model) { double }
    it "returns true if save! succeeds" do
      expect(model).to receive(:save!).and_return(true)
      expect(subject).to receive(:model).and_return(model)

      expect(subject.save_model).to be true
    end

    it "raises if not save does" do
      expect(model).to receive(:save!).and_raise(StandardError)
      expect(subject).to receive(:model).and_return(model)

      expect{subject.save_model}.to raise_error(ActiveProcedure::SaveModelError)
    end
  end
end
