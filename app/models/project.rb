# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  due             :datetime
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  professional_id :integer
#  quotation_id    :integer
#  request_id      :integer
#

class Project < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
