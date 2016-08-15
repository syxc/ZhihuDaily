source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!

def pods
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'swift2.3'
  pod 'ObjectMapper', '~> 1.1'
  pod 'MBProgressHUD', '~> 0.9.2'
  pod 'FYLogger'
  pod 'Hue'
end

target 'ZhihuDaily' do
  pods
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    # Configure Pod targets for Xcode 8 compatibility
    config.build_settings['SWIFT_VERSION'] = '2.3'
    config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
  end
end
