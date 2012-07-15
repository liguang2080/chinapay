module Chinapay
  # 配置采用统一的 parter_id key seller
  def self.load_config
    begin
      # filename = "#{Rails.root}/config/chinapay.yml"
      filename = File.expand_path(File.dirname(__FILE__) + "/../chinapay.yml")
      CONFIG = YAML.load(File.open(filename))
    rescue Exception => e
      puts <<-EXAMPLE
      ---
        tencent:
        parter: 1211116701
      key: 3b46d59ae2095e6d9d0f95e4f510e962
      seller: 1211116701
      alipay:
        parter: 1211116701
      key: 3b46d59ae2095e6d9d0f95e4f510e962
      seller: lg2046@gmail.com
      EXAMPLE
      raise "Please configure your Chinapay settings in #{filename}."
    end
  end
end
