class ParticipantToken < ActiveRecord::Base
  belongs_to :participant

  before_save :encrypt_token

  def encrypt_token
    hashids = Hashids.new
    self.token = hashids.encrypt(self.participant_id, self.release_date.to_i)
  end

  def self.decrypt_token(token)
    hashids = Hashids.new
    hashids.decrypt(token)
  end
end
