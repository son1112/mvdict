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

      it 'is expected to remove the provided value from the key collection' do
        subject.remove('foo', 'bar')
        expect(subject.dictionary['foo']).not_to include('bar')
      end

      it 'is expected to return `Removed`' do
        expect(subject.remove('foo', 'bar')).to eq('Removed')
      end
    end
    context 'when the provided key does not exist in the dictionary' do
      it 'is expected to raise MISSING_KEY_ERROR' do
        expect{ subject.remove('abc', '123') }.to raise_error(
          MvDict::Errors::ReplErrors::MISSING_KEY_ERROR
        )
      end
    end
    context 'when the provided value does not exist in the collection' do
      let(:dictionary) { single_item_dictionary }
      it 'is expected to raise MISSING_VALUE_ERROR' do
        expect{ subject.remove('foo', 'bit') }.to raise_error(
          MvDict::Errors::ReplErrors::MISSING_VALUE_ERROR
        )
      end
    end
  end
  describe '#removeall' do
    context 'when the provided key does exist in the dictionary' do
      let(:dictionary) { single_item_dictionary }

      it 'is expected to delete the key and values from the dictionary' do
        subject.removeall('foo')
        expect(subject.dictionary.keys).not_to include('foo')
      end

      it 'is expected to return `Removed`' do
        expect(subject.removeall('foo')).to eq('Removed')
      end
    end

    context 'when the provided key does not exist in the dictionary' do
      it 'is expected to raise MISSING_KEY_ERROR' do
        expect{ subject.removeall('key') }.to raise_error(
          MvDict::Errors::ReplErrors::MISSING_KEY_ERROR
        )
      end
    end
  end
  describe '#clear' do
    let(:dictionary) { multi_item_dictionary }

    it 'is expected to reset the dictionary to an empty hash' do
      expect(subject.dictionary).to eq(multi_item_dictionary)
      subject.clear
      expect(subject.dictionary).to eq(Hash.new([]))
    end

    it 'is expected to return `Cleared`' do
      expect(subject.clear).to eq('Cleared')
    end
  end

  describe '#keyexists' do
    context 'when the provided key exists in the dictionary' do
      let(:dictionary) { single_item_dictionary }

      it 'is expected to return true' do
        expect(subject.keyexists('foo')).to be(true)
      end
    end

    context 'when the provided key does not exist in the dictionary' do
      it 'is expected to return false' do
        expect(subject.keyexists('bat')).to be(false)
      end
    end
  end

  describe '#valueexists' do
    context 'when the provided key does not exist in the dictionary' do
      it 'is expected to return false' do
        expect(subject.valueexists('foo', 'boot')).to be(false)
      end
    end

    context 'when the provided key does exist in the dictionary' do
      let(:dictionary) { single_item_dictionary }

      context 'when the provided value does not exist in the provided key collection' do
        it 'is expected to return false' do
          expect(subject.valueexists('foo', 'boot')).to be(false)
        end
      end

      context 'when the provided value does exist in the provided key collection' do
        it 'is expected to return true' do
          expect(subject.valueexists('foo', 'bar')).to be(true)
        end
      end
    end
  end

  describe '#allmembers' do
    let(:dictionary) { multi_item_dictionary }

    it 'is expected to return all values from all keys in the dictionary' do
      expect(subject.allmembers).to eq(multi_item_dictionary.values.flatten)
    end
  end

  describe 'items' do
    context 'when there are no items in the dictionary' do
      it 'is expected to return nil' do
        expect(subject.items).to be_nil
      end
    end

    context 'when there is at least one item in the dictionary' do
      let(:dictionary) { multi_item_dictionary }

      it 'is expected to return an array of value strings' do
        expect(subject.items).to eq(
          [
            'foo: bar',
            'foo: biz',
            'who: done',
            'who: it',
            'fruits: apple',
            'fruits: orange',
            'fruits: fig'
          ]
        )
      end
    end
  end
end
