Pod::Spec.new do |s|
  s.name         = "KG_GCDTimer"
  s.version      = "0.0.1"
  s.summary      = "USE GCDTIMER NOT NSTIMER."
  s.description  = <<-DESC
                    GCDTimer
                   DESC
  s.homepage     = "https://github.com/KunkkaQI/KG_GCDTimer"
  s.license      = "MIT"
  s.author             = { "KunkkaQI" => "KunkkaQI@users.noreply.github.com" }
  s.source       = { :git => "https://github.com/KunkkaQI/KG_GCDTimer.git", :tag => s.version}
  s.ios.deployment_target = '8.0'
  s.source_files = 'KG_GCDTimer'
  s.requires_arc = true
end
