class ForbiddenNameValidator < ActiveModel::Validator
  def validate(record)
    return if record.name.nil?
    return unless record.name.include?('invalid')
    record.errors[:name] << "Name field cannot contain 'invalid' value. Please supply different name."
  end
end
