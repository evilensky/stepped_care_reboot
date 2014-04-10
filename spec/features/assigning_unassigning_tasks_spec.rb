require "spec_helper"

describe "Tasks" do
  fixtures(
    :participants, :users, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/tools", :"bit_player/content_modules",
    :"bit_player/content_providers", :groups, :memberships,
    :group_slideshow_joins, :tasks, :task_status
  )

  let(:user) { users(:user1) }
  let(:group2) { groups(:group2) }
  let(:group) { groups(:group1) }
  let(:task1) { tasks(:task1) }
  let(:task_status1) { task_status(:task_status1) }
  let(:task2) { tasks(:task2) }
  let(:task_status2) { task_status(:task_status2) }
  let(:do_awareness) { bit_player_content_modules(:do_awareness) }
  let(:do_planning) { bit_player_content_modules(:do_planning) }
  let(:do_doing) { bit_player_content_modules(:do_doing) }

  before do
    sign_in_user user
  end

  it "Assign task" do
    visit manage_tasks_group_path(group2)
    task = Task.where(bit_player_content_module_id: do_doing.id, release_day: 1, group_id: group2.id).first
    expect(task).to be_nil
    select("Doing", from: "Select Module")
    fill_in "Release day", with: 1
    click_on "Assign"
    task = Task.where(bit_player_content_module_id: do_doing.id, release_day: 1, group_id: group2.id).first
    expect(task).to_not be_nil
  end

  it "Unassign task" do
    visit manage_tasks_group_path(group)
    task = Task.where(bit_player_content_module_id: do_awareness.id, release_day: 1, group_id: group.id).first
    expect(task).to_not be_nil
    with_scope "#task-#{task.id}" do
      click_on "Unassign"
    end
    task = Task.where(bit_player_content_module_id: do_awareness.id, release_day: 1, group_id: group.id).first
    expect(task).to be_nil
  end
end