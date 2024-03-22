Pod::Spec.new do |s|
  s.name             = 'ChartIQ'
  s.version          = '4.2.0'
  s.swift_version    = '5'
  s.summary          = 'ChartIQ'

  s.description      = <<-DESC
 	ChartIQ SDK for Swift
                       DESC

  s.homepage         = 'https://github.com/ChartIQ/ChartIQ-iOS-SDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chartiq' => 'jacob.richards@spglobal.com' }
  s.source           = { :git => 'https://github.com/ChartIQ/ChartIQ-iOS-SDK.git', :tag => s.version.to_s }

  s.platform = :ios, '12.0'
  s.ios.deployment_target = '15.0'
  s.source_files = 'Source/*'
  s.exclude_files = "ChartIQ/**/*.plist"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }

end
