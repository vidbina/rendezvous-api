class RedisAdaptor
  def initialize(tokens, redis)
    @tokens = tokens
    @redis = redis
  end

  def save_if_nonexistent(id, val)
    redis.setnx(id, val)
  end

  def save_and_possibly_overwrite(id, val)
  end

  def get(id)
  end
end
