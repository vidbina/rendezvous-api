class RedisAdaptor
  def initialize(tokens, redis)
    @tokens = tokens
    @redis = redis
  end

  def save_if_nonexistent(id, val)
    if val.kind_of? Hash
      if !@redis.exists? id
        (true if @redis.hmset(id, val.each.map{ |k, v| [k, v] }.flatten) == "OK") or false
      else
        false
      end
    else
      (true if @redis.setnx(id, val) == "OK") or false
    end
  end

  def save_and_possibly_overwrite(id, val)
    if val.kind_of? Hash
      arr = *val.each.map{ |k, v| [k, v] }.flatten
      res = @redis.hmset(id, arr)
      (true if @redis.exists(id)) or false
    else
      (true if @redis.set(id, val) == "OK") or false
    end
  end

  def get(id, type=nil)
    if @redis.type(id) == "hash"
      @redis.hgetall(id)
    else
      @redis.get(id)
    end
  end
end
