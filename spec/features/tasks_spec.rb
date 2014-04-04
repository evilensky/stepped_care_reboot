require "spec_helper"

describe "Tasks" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :group_slideshow_joins, :tasks
  )

  let(:participant) { participants(:participant1) }
  let(:task1) { tasks(:task1) }
  let(:task2) { tasks(:task2) }

  before do
    sign_in_participant participant
    visit ""
  end

  # TASK MODELS SHOULD NOT HOLD STATUS! - that needs to be in a different MODEL!
  it "User should see notifications on the 'Landing Page' and 'Contenxt Page' until modules have been 'activated'" do
    expect(page.html).to include("<a href=\"/navigator/contexts/activity_tracker\"><i class=\"fa fa-asterisk\"></i> DO</a>")
    visit "/navigator/contexts/activity_tracker"
    expect(page.html).to include("<a class=\"module\" data-id=\"143279406\" href=\"/navigator/modules/339588004\"><i class=\"fa fa-asterisk\"></i> #1 Awareness</a>")
    expect(page.html).to include("<a class=\"module\" data-id=\"293803154\" href=\"/navigator/modules/926344597\"><i class=\"fa fa-asterisk\"></i> #2 Planning</a>")
    expect(Task.for_participant(participant).find(task1.id).is_complete).to eq true
    click_on("#1 Awareness")
    puts  "Task.for_participant(participant) = #{Task.for_participant(participant).all}"
    expect(Task.for_participant(participant).find(task1.id).is_complete).to eq false
    visit "/navigator/contexts/activity_tracker"
    click_on("#2 Planning")
    click_on "Home"
    expect(page.html).not_to include("<i class=\"fa fa-asterisk\">")
    click_on "DO"
    expect(page.html).not_to include("<i class=\"fa fa-asterisk\">")
  end

end