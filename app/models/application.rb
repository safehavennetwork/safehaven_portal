class Application
  attr_accessor :name, :icon, :id, :type

  def initialize(app_hash)
    @name = app_hash[:name]
    @icon = app_hash[:icon]
    @id   = app_hash[:id]
    @type = app_hash[:type]
  end
end
