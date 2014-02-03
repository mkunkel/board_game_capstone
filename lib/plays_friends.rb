require_relative 'environment'
class PlaysFriends
  attr_reader :plays_id, :friends_id

  def initialize plays_id, friends_id
    @plays_id = plays_id
    @friends_id = friends_id
  end

  def save
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "INSERT INTO plays_friends(plays_id, friends_id
                 ) VALUES('#{plays_id}', '#{friends_id}')"
    Environment.logger.info("Executing CREATE: " + statement)
    db.execute(statement)
    self
  end

  private

  def plays_id= id
    @plays_id = id
  end

  def friends_id= id
    @friends_id = id
  end
end