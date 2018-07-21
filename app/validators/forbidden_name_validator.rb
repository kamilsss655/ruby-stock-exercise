class ForbiddenNameValidator < ActiveModel::Validator
  def validate(record)
    if record.name == 'invalid'
      record.errors[:name] << "Name field cannot have 'invalid' value. Please supply different name."
    end
  end
end
