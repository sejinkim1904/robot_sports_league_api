class RoleCountValidator < ActiveModel::Validator
  def validate(record)
    return if record.benchwarmer?
    return unless record.team.rosters.starter.size >= 10
    return unless record.team.rosters.alternate.size >= 5

    if record.starter?
      record.errors.add :roster, 'cannot have more than 10 starters.'
    else
      record.errors.add :roster, 'cannot have more than 5 alternates.'
    end
  end
end
