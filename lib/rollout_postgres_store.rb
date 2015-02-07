class RolloutPostgresStore
  def initialize(model, attribute)
    @model = model
    @attribute = attribute
  end

  def get(key)
    if flag = @model.where("#{@attribute} ? '#{key}'").first
      flag.send(@attribute)[key]
    end
  end

  def set(key, value)
    current = get(key)

    if current.nil?
      create_feature_flag(key, value)
    else
      update_flag(key, value)
    end
  end

  def del(key)
    if flag = @model.where("#{@attribute} ? '#{key}'").first
      flag.delete
    end
  end

  private
  def create_feature_flag(key, value)
    flag = @model.new
    flag.send("#{@attribute}=", { key => value })
    flag.save
  end

  def update_flag(key, value)
    flag = @model.where("#{@attribute} ? '#{key}'").first
    flag.send(@attribute)[key] = value
    flag.send("#{@attribute}_will_change!")
    flag.save
  end
end
