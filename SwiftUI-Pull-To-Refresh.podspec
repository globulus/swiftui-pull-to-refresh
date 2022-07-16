Pod::Spec.new do |s|
  s.name             = 'SwiftUI-Pull-To-Refresh'
  s.version          = '1.1.6'
  s.summary          = 'Pull to refresh on any SwiftUI Scroll View.'
  s.homepage         = 'https://github.com/globulus/swiftui-pull-to-refresh'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gordan Glavaš' => 'gordan.glavas@gmail.com' }
  s.source           = { :git => 'https://github.com/globulus/swiftui-pull-to-refresh.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '4.0'
  s.source_files = 'Sources/SwiftUIPullToRefresh/**/*'
end
