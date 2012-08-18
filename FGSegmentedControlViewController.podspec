Pod::Spec.new do |s|
  s.name         = "FGSegmentedControlViewController"
  s.version      = "0.1.0"
  s.summary      = "FGSegmentedControlViewController is a container view controller that manages view controllers through a UISegmentedControl."
  s.homepage     = "http://github.com/FernGlow/FGSegmentedControlViewController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrew Michaelson" => "andrew@fernglow.com" }
  s.source       = { :git => "http://github.com/FernGlow/FGSegmentedControlViewController.git", :tag => "0.1.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'FGSegmentedControlViewController'
  s.preserve_paths = ['FGSegmentedControlViewController', 'README.md', 'LICENSE']
  s.requires_arc = true
end