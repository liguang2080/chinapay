module Chinapay
  
  class << self; attr_accessor :config; end
  
  # 配置采用统一的 parter_id key seller
  def self.load_config
    begin
      # filename = "#{Rails.root}/config/chinapay.yml"
      filename = File.expand_path(Rails.root.to_s + "/config/chinapay.yml")
      @config = YAML.load(File.open(filename))[Rails.env]
    rescue Exception => e
      puts <<-EXAMPLE
      ---
      development:
        tencent:
          parter: 121111XXXX
          key: XXXXXXXXXXXXXXXXXX
          seller: 121111XXXX
        alipay:
          parter: 12111XXXX
          key: XXXXXXX
          seller: XXXXX@XXXXX.com
      EXAMPLE
      raise "Please configure your Chinapay settings in #{filename}."
    end
  end
end
