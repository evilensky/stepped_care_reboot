require "spec_helper"

describe "Tasks" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides", :"bit_player/tools",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :tasks, :task_status
  )

  let(:participant) { participants(:participant1) }
  let(:task1) { tasks(:task1) }
  let(:task_status1) { task_status(:task_status1) }
  let(:task2) { tasks(:task2) }
  let(:task_status2) { task_status(:task_status2) }

  before do
    sign_in_participant participant
    visit ""
  end

  it "User should see notifications on the 'Landing Page' and 'Context Page' until modules have been 'activated'", :js do
    expect(page.html).to include("<a href=\"/navigator/contexts/DO\"><i class=\"fa fa-asterisk\"></i> DO</a>")
    visit "/navigator/contexts/DO"
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"#{task_status1.id}\" href=\"/navigator/modules/#{task_status1.task.bit_player_content_module.id}\"><i class=\"fa fa-asterisk\"></i> #1 Awareness</a>")
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"#{task_status2.id}\" href=\"/navigator/modules/#{task_status2.task.bit_player_content_module.id}\"><i class=\"fa fa-asterisk\"></i> #2 Planning</a>")
    click_on("#1 Awareness")
    visit "/navigator/contexts/DO"
    click_on("#2 Planning")
    click_on "Home"
    expect(page.html).to include("<a href=\"/navigator/contexts/DO\">DO</a>")
    click_on "DO"
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"false\" href=\"/navigator/modules/#{task_status1.task.bit_player_content_module.id}\">#1 Awareness</a>")
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"false\" href=\"/navigator/modules/#{task_status2.task.bit_player_content_module.id}\">#2 Planning</a>")
  end

end