require 'spec_helper'

RSpec.describe MvDict::Commanders::Basic do
  subject { described_class.new(dictionary) }

  let(:dictionary) { {} }
  let(:single_item_dictionary) do
    { 'foo' => ['bar'] }
  end
  let(:multi_item_dictionary) do
    {
      'foo' => ['bar', 'biz'],
      'who' => ['done', 'it'],
      'fruits' => ['apple', 'orange', 'fig']
    }
  end

  describe '#initialize' do
    it 'is expected to initialize without arguments' do
      expect(subject).to be_a(MvDict::Commanders::Basic)
    end
  end
  describe '#keys' do
    context 'when no keys exist in the dictionary' do
      it 'is expected to return nil' do
        expect(subject.keys).to be_nil
      end
    end

    context 'when keys exist in the dictionary' do
      context 'with a single key' do
        let(:dictionary) { single_item_dictionary }

        it 'is expected to return an array' do
          expect(subject.keys).to be_a(Array)
          expect(subject.keys.size).to eql(1)
        end
        it 'is expected to contain strings' do
          expect(
            subject.keys.select do |key|
              !key.is_a?(String)
            end
          ).to be_empty
        end
        it 'is expected to contain the right keys' do
          expect(subject.keys).to eq(single_item_dictionary.keys)
        end
      end

      context 'with multiple keys' do
        let(:dictionary) { multi_item_dictionary }

        it 'is expected to contain the right keys' do
          keys = subject.keys
          expect(keys.size).to eql(3)
          expect(keys).to eq(multi_item_dictionary.keys)
        end
      end
    end
  end
  describe '#members' do
    context 'when the key exists in the dictionary' do
      let(:dictionary) { multi_item_dictionary }

      it 'is expected to return value array for the provided key' do
        expect(subject.members('foo')).to eq(multi_item_dictionary['foo'])
      end
    end

    context 'when the key does not exist in the dictionary' do
      it 'is expected to raise MISSING_KEY_ERROR' do
        expect{ subject.members('foo') }.to raise_error(
          MvDict::Errors::ReplErrors::MISSING_KEY_ERROR
        )
      end
    end
  end
  describe '#add' do
    context 'when the value for the provided key does not exist' do
      let(:dictionary) { multi_item_dictionary }

      it 'is expected to add the value to the provided key in the dictionary' do
        subject.add('foo', 'ADD')
        expect(subject.members('foo')).to include('ADD')
      end

      it 'is expected to return `Added`' do
        expect(subject.add('foo', 'bot')).to eql('Added')
      end
    end

    context 'when the value for the provided key already exists' do
      let(:dictionary) { multi_item_dictionary }

      it 'is expected to raise DUPLICATE_VALUE_ERROR' do
        expect{ subject.add('foo', 'bar') }.to raise_error(
          MvDict::Errors::ReplErrors::DUPLICATE_VALUE_ERROR
        )
      end
    end
  end
  describe '#remove' do
    context 'when the provided value exists in the collection' do
      let(:dictionary) { multi_item_dictionary }
      it 'is expected to remove the provided value from the collection'
    end
    context 'when the provided key does not exist in the dictionary' do
      it 'is expected to raise MISSING_KEY_ERROR'
    end
    context 'when the provided value does not exist in the collection' do
      it 'is expected to raise MISSING_VALUE_ERROR'
    end
  end
  describe '#removeall' do
    context 'when the provided key does exist in the dictionary' do
      it 'is expected to '
    end
    context 'when the provided key does not exist in the dictionary' do
      it 'is expected to raise MISSING_KEY_ERROR'
    end
  end
  describe '#clear'
  describe '#keyexists'
  describe '#valueexists'
  describe '#allmembers'
  describe 'items'
end
