module ActiveModel
  module Validations
    class LengthValidator < EachValidator
      def validate_each(record, attribute, value)
        value = options[:tokenizer].call(value) if value.kind_of?(String)

        CHECKS.each do |key, validity_check|
          next unless check_value = options[key]
          
          check_value = check_value * I18nToolbox.character_ratio if options[:localize]

          value ||= [] if key == :maximum

          value_length = value.respond_to?(:length) ? value.length : value.to_s.length
          next if value_length.send(validity_check, check_value)

          errors_options = options.except(*RESERVED_OPTIONS)
          errors_options[:count] = check_value

          default_message = options[MESSAGES[key]]
          errors_options[:message] ||= default_message if default_message

          record.errors.add(attribute, MESSAGES[key], errors_options)
        end
      end
    end
  end
end