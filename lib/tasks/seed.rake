require 'active_record/fixtures'

module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      # PostgreSQL only disables referential integrity when connection
      # user is root and that is not the case.
      def disable_referential_integrity
        yield
      end
    end
  end
end

namespace :seed do
  desc 'seed the database with fixtures from spec/fixtures'
  task with_fixtures: :environment do
    path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures')
    ActiveRecord::FixtureSet.create_fixtures path, [
      :participants, :'bit_player/slideshows', :'bit_player/slides',
      :'bit_player/content_modules', :'bit_player/content_providers', :users,
      :activity_types, :activities, :coach_assignments, :groups, :memberships,
      :messages, :delivered_messages, :thought_patterns, :thoughts,
      :group_slideshow_joins
    ]
  end
end
