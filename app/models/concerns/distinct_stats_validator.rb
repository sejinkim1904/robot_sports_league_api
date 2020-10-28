class DistinctStatsValidator < ActiveModel::Validator
  def validate(record)
    return if record.benchwarmer? || record.in?(record.team.current_roster)
    return unless record.total_stats.in?(
      record.team.current_roster.pluck(:total_stats)
    )

    record.errors.add :total_stats, 'must be unique on your roster'
  end
end
