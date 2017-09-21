#
#  Be sure to run `pod spec lint SwiftyArk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "SwiftyArk"
  s.version       = "1.1.9"
  s.summary       = "An Ark cryptocurrency framework written in Swift"
  s.description   = "SwiftyArk is a ligthweight Ark cryptocurrency written in Swift. SwiftyArk allows iOS and Mac applications to interact with the Ark Ecosystem"
  s.homepage      = "https://github.com/Awalz/SwiftyArk"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "Andrew Walz" => "andrewjwalz@gmail.com" }
  s.source        = { :git => "https://github.com/Awalz/SwiftyArk.git", :tag => "#{s.version}" }
  s.source_files  = 'Source/**/*'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = "10.10"
end
