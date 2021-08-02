# == Schema Information
#
# Table name: servers
#
#  id          :bigint           not null, primary key
#  last_update :datetime
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Server < ApplicationRecord
end
