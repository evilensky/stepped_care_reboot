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

  before do
    sign_in_participant participants(:participant1)
    visit ""
  end

  it "should see notifications on the 'Landing Page' and 'Context Page' until modules have been 'activated'", :js do
    expect(page.html).to include("<a href=\"/navigator/contexts/DO\"><i class=\"fa fa-asterisk\"></i> DO</a>")
    visit "/navigator/contexts/DO"
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"#{ts1.id}\" href=\"/navigator/modules/#{ts1_module.id}\"><i class=\"fa fa-asterisk\"></i> #1 Awareness</a>")
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"#{ts2.id}\" href=\"/navigator/modules/#{ts2_module.id}\"><i class=\"fa fa-asterisk\"></i> #2 Planning</a>")
    click_on("#1 Awareness")
    visit "/navigator/contexts/DO"
    click_on("#2 Planning")
    click_on "Home"
    expect(page.html).to include("<a href=\"/navigator/contexts/DO\">DO</a>")
    click_on "DO"
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"false\" href=\"/navigator/modules/#{ts1_module.id}\">#1 Awareness</a>")
    expect(page.html).to include("<a class=\"content-module\" data-task-status-id=\"false\" href=\"/navigator/modules/#{ts2_module.id}\">#2 Planning</a>")
  end

  it "should continue to see lesson slideshows even after they have been activated", :js do
    visit "/navigator/contexts/LEARN"
    expect(page.html).to include("<a href=\"/navigator/modules/#{learning_ts_module.id}/providers/#{learning_ts_provider.id}/1\" class=\"list-group-item content-module\" data-task-status-id=\"#{learning_ts.id}\"><i class=\"fa fa-asterisk\"></i> Do - Awareness Introduction</a>")
    click_on "Do - Awareness Introduction"
    visit "/navigator/contexts/LEARN"
    expect(page).to have_link("Do - Awareness Introduction")
    expect(page.html).to include("<a href=\"/navigator/modules/#{learning_ts_module.id}/providers/#{learning_ts_provider.id}/1\" class=\"list-group-item content-module\" data-task-status-id=\"#{learning_ts.id}\">Do - Awareness Introduction</a>")
  end
end