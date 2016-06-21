Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "JBButton"
s.summary = "JBButton is a configurable and animatable button written in Swift."
s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Jérôme Boursier" => "jjbourdev@gmail.com" }

s.homepage = "https://github.com/jjbourdev/JBButton"

s.source = { :git => "https://github.com/jjbourdev/JBButton.git", :tag => "#{s.version}"}

s.framework = "UIKit"

s.source_files = "JBButton/**/*.{swift}"

end