require "spec_helper"

describe "Participant accessing tasks" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides", :"bit_player/tools",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :tasks, :task_status
  )

  let(:ts1) { task_status(:task_status1) }
  let(:ts1_module) { ts1.task.bit_player_content_module }
  let(:ts2) { task_status(:task_status2) }
  let(:ts2_module) { ts2.task.bit_player_content_module }
  let(:learning_ts) { task_status(:task_status3) }
  let(:learning_ts_module) { learning_ts.task.bit_player_content_module }
  let(:learning_ts_provider) { learning_ts_module.content_providers.last }

  let(:unassigned_module) do
    BitPlayer::ContentModule.create(
      title: "#4 Doing",
      tool_id: bit_player_tools(:activity_tracker),
      position: 5
    )
  end

  before do
    sign_in_participant participants(:participant1)
    visit ""
  end

  it "should see notifications on the 'Landing Page' and 'Context Page' until modules have been 'activated'", :js do
    do_icon_count = find_link("DO").all("i.fa-asterisk").count
    expect(do_icon_count).to eq 1
    visit "/navigator/contexts/DO"
    awareness_icon_count = find_link("#1 Awareness").all("i.fa-asterisk").count
    expect(awareness_icon_count).to eq 1
    planning_icon_count = find_link("#2 Planning").all("i.fa-asterisk").count
    expect(planning_icon_count).to eq 1
    click_on("#1 Awareness")
    visit "/navigator/contexts/DO"
    click_on("#2 Planning")
    click_on "Home"
    do_icon_count = find_link("DO").all("i.fa-asterisk").count
    expect(do_icon_count).to eq 0
    click_on "DO"
    awareness_icon_count = find_link("#1 Awareness").all("i.fa-asterisk").count
    expect(awareness_icon_count).to eq 0
    planning_icon_count = find_link("#2 Planning").all("i.fa-asterisk").count
    expect(planning_icon_count).to eq 0
  end

  it "User should not see unassigned content modules", :js do
    visit "/navigator/contexts/DO"
    expect(page.html).to include("#3 Doing")
    expect(page.html).not_to include("#4 Doing")
  end

  it "should continue to see lesson slideshows even after they have been activated", :js do
    visit "/navigator/contexts/LEARN"
    click_on "Do - Awareness Introduction"
    visit "/navigator/contexts/LEARN"
    expect(page).to have_link("Do - Awareness Introduction")
  end
end