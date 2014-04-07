require 'spec_helper'

describe TaskStatus do
  fixtures(
    :users, :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :group_slideshow_joins, :tasks
  )

  let(:user) { users(:user1) }
  let(:group) { groups(:group1) }
  let(:participant) { participants(:participant1) }
  let(:membership) { memberships(:membership1) }
  let(:think_identifying) { bit_player_content_modules(:think_identifying) }

  it "should be created and assigned to members when a task is assigned to a group" do
    task = Task.where(group: group, bit_player_content_module: think_identifying).first
    expect(task).to be_nil
    task = user.tasks.build(group: group, bit_player_content_module: think_identifying)
    task.save!
    task = Task.where(group: group, bit_player_content_module: think_identifying).first
    expect(task).not_to be_nil
    status = TaskStatus.where(membership_id: membership.id, task: task).first
    expect(status).not_to be_nil
  end

  # depended destroy on task..

  # delegate :release_day

end
