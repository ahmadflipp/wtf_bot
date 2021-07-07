class WtfDictionary < ApplicationRecord
end

# == Schema Information
#
# Table name: wtf_dictionaries
#
#  id          :bigint           not null, primary key
#  author      :string(255)
#  description :string(255)
#  word        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
