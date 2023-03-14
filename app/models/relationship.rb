class Relationship < ApplicationRecord
  
  belongs_to :follow_suru, class_name: "User"
  belongs_to :follow_sareru, class_name: "User"
  
end
