module RansackableMaterial
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_attributes(_auth_object = nil)
      %w[name]
    end
  end
end
