#
#  Be sure to run `pod spec lint KG_GCDTimer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "KG_GCDTimer"
  s.version      = "0.0.1"
  s.summary      = "USE GCDTIMER NOT NSTIMER."
  s.homepage     = "https://github.com/KunkkaQI/KG_GCDTimer"
  s.license      = "MIT"
  s.author             = { "KunkkaQI" => "KunkkaQI@users.noreply.github.com" }
  s.source       = { :git => "https://github.com/KunkkaQI/KG_GCDTimer.git", :tag => s.version, :submodules => true }
  s.public_header_files = 'KG_GCDTimer/KG_GCDTimer.h'
  s.source_files = 'KG_GCDTimer/KG_GCDTimer.h'
  s.requires_arc = true
end
