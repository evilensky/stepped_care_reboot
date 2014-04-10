require "spec_helper"

describe TaskStatus do
  fixtures(
    :users, :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :tasks
  )

  let(:user) { users(:user1) }
  let(:group) { groups(:group2) }
  let(:participant) { participants(:active_participant) }
  let(:membership) { memberships(:active_membership) }
  let(:think_identifying) { bit_player_content_modules(:think_identifying) }

  it "should be created and assigned to members when a task is assigned to a group" do
    tasks = membership.tasks.count
    task = Task.where(group: group, bit_player_content_module: think_identifying, release_day: 1).first
    expect(task).to be_nil
    task = user.tasks.build(group: group, bit_player_content_module: think_identifying, release_day: 1)
    task.save!
    task = Task.where(group: group, bit_player_content_module: think_identifying, release_day: 1).first
    expect(task).not_to be_nil
    membership.reload
    expect(membership.tasks.count).to eq tasks + 1
    status = TaskStatus.where(membership_id: membership.id, task: task).first
    expect(status).not_to be_nil
  end
end