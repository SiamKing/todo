class Item < ApplicationRecord
    belongs_to :list, optional: true

    validates :description, presence: true
    STATUS = {
        incomplete: 0,
        complete: 1
    }

    def complete?
        status == STATUS[:complete]
    end

    def incomplete?
        status == STATUS[:incomplete]
    end
end
