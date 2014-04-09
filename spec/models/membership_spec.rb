require "spec_helper"

describe Membership do
  fixtures [:users, :groups, :participants, :memberships]

  describe "validations" do

    it "allows one active membership for a participant" do
      new_membership = Membership.new(
        group_id: groups(:group1).id,
        participant_id: participants(:inactive_participant).id,
        start_date: Date.today,
        end_date: Date.tomorrow
      )
      expect(new_membership).to be_valid
    end

    it "does not allow more than one active membership for a participant" do
      new_membership = Membership.new(
        group_id: groups(:group1).id,
        participant_id: participants(:active_participant).id,
        start_date: Date.today,
        end_date: Date.tomorrow
      )
      expect(new_membership).not_to be_valid
    end
  end
end
      