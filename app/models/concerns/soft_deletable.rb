require 'active_support/concern'

module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :with_deleted, -> { unscoped }
    scope :only_deleted, -> { unscoped.where.not(deleted_at: nil) }

    def soft_delete
      update(deleted_at: Time.now)
    end
  end
end
