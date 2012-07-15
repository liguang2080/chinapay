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
