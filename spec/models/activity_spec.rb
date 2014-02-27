require 'spec_helper'

describe Activity do
	fixtures [:participants, :activity_types, :activities]

	describe "create activity type" do

		it "should create an activity type when it has an activity type title" do
			activity = Activity.create(
        participant: participants(:participant1),
        activity_type_title: "prancing in the woods",
        start_time: Time.now,
        end_time: Time.now + 1.hour
      )
			expect(participants(:participant1).activity_types.exists?(title: "prancing in the woods")).to be true
		end

		it "should not create an activity type when it does not have an activity type title" do
			activity = Activity.create(
        participant: participants(:participant1),
        start_time: Time.now,
        end_time: Time.now + 1.hour
      )
			expect(participants(:participant1).activity_types.exists?(title: "prancing in the woods")).to be false
		end

	end

	# describe "scopes" do
	# 	it "unplanned should only show activities where start_time and end_time are nil" do
	# 		unplanned_activities = Activity.unplanned
	# 		unplanned_activities.count.to_not be_empty
	# 		unplanned_activities.each do |a|
	# 			a.start_time.to be nil
	# 			a.end_time.to be nil
	# 		end
	# 	end
	# end

end
