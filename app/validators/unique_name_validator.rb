class UniqueJournalValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        if record.name_changed?
            record.errors[attribute] << 'name must be unique' unless
                Journal.by_name(value).empty?
        end
    end
end

class UniquePublisherValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        record.errors[attribute] << 'name must be unique' unless
            Publisher.by_name(value).empty?
    end
end

class UniqueEntityRefValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        record.errors[attribute] << 'name must be unique' unless
            Journal.by_name(value).empty? && Publisher.by_name(value).empty?
    end
end
