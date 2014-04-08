require "spec_helper"

describe TaskStatus do
  fixtures(
    :users, :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :group_slideshow_joins, :tasks
  )

  let(:task1) { tasks(:task1) }

  it "should not allow a group and module to be assigned on the same release day" do
    expect(Task.new(group_id: task1.group_id, bit_player_content_module_id: task1.bit_player_content_module_id, release_day: task1.release_day)).
      to have(1).errors_on(:release_day)
  end

end
