require 'spec_helper'

describe Activity do
	fixtures :participants

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
end
