module AuthHelper
  def auth_team(team)
    allow(JWT).to receive(:decode).and_return([{ 'team_id' => team.id }])
  end
end
