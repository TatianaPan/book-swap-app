module Strippable
  include ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      def strip_input_fields
        self.class::STRIPPABLE_ATTRIBUTES.each do |attribute_name|
          send("#{attribute_name}=", send(attribute_name).strip) unless attribute_name.nil?
        end
      end
    end
  end
end
