# frozen_string_literal: true

class MvDict
  class Commanders
    class Basic
      include MvDict::Errors::ReplErrors

      attr_reader :dictionary

      def initialize(dictionary = Hash.new([]))
        @dictionary = dictionary
      end

      # Returns all the keys in the dictionary.
      # Order is not guaranteed.
      def keys
        return unless existing_keys.any?

        existing_keys
      end

      # Returns the collection of strings for the given key.
      # Return order is not guaranteed.
      # Returns an error if the key does not exists.
      def members(key)
        raise MISSING_KEY_ERROR unless @dictionary[key]

        @dictionary[key]
      end

      # Add a member to a collection for a given key.
      # Displays an error if the value already existed in the collection.
      def add(key, value)
        raise DUPLICATE_VALUE_ERROR if value_exists?(key, value)

        @dictionary[key] << value
        'Added'
      end

      # Removes a value from a key.
      # If the last value is removed from the key, the key is removed from the dictionary.
      # If the key or value does not exist, displays an error.
      def remove(key, value)
        raise MISSING_KEY_ERROR unless key_exists?(key)
        raise MISSING_VALUE_ERROR unless value_exists?(key, value)

        @dictionary[key].delete(value)
        'Removed'
      end

      # Removes all value for a key and removes the key from the dictionary.
      # Returns an error if the key does not exist.
      def removeall(key)
        raise MISSING_KEY_ERROR unless key_exists?(key)

        @dictionary.delete(key)
        'Removed'
      end

      # Removes all keys and all values from the dictionary.
      def clear
        @dictionary = Hash.new([])
        'Cleared'
      end

      # Returns whether a key exists or not.
      def keyexists(key)
        key_exists?(key)
      end

      # Returns whether a value exists within a key.
      # Returns false if the key does not exist.
      def valueexists(key, value)
        return false unless key_exists?(key)

        value_exists?(key, value)
      end

      # Returns all the values in the dictionary.
      # Returns nothing if there are none.
      # Order is not guaranteed.
      def allmembers
        @dictionary.values.flatten
      end

      # Returns all keys in the dictionary and all of their values.
      # Returns nothing if there are none.
      # Order is not guaranteed.
      def items
        return unless @dictionary
        return if @dictionary.empty?

        value_names = []

        @dictionary.each_with_index do |pair, index|
          key = pair[0]
          values = pair[1]

          values.each_with_index.collect do |value, index|
            value_names << "#{key}: #{value}"
          end
        end

        value_names
      end

      private

      def existing_keys
        @dictionary.keys
      end

      def key_exists?(key)
        @dictionary.has_key?(key)
      end

      def value_exists?(key, value)
        @dictionary[key].include?(value)
      end

      def all_members
        @dictionary.values.flatten
      end
    end
  end
end
