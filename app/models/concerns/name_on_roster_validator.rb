class NameOnRosterValidator < ActiveModel::Validator
  def validate(record)
    return if record.benchwarmer? || record.in?(record.team.current_roster)
    return unless record.bot.name.in?(record.team.current_roster.bot_names)

    record.errors.add :bot_name, 'must be unique on roster'
  end
end
