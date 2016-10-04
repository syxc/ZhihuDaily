source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!

def pods
  pod 'Alamofire', '3.5.0' # Swift 2.3 Support and Bug Fixes
  pod 'ObjectMapper', '~> 1.1'
  pod 'MBProgressHUD', '~> 0.9.2'
  pod 'PromiseKit', '3.5.0'
  pod 'Device', '~> 1.0.3'
  pod 'SDWebImage', '~>3.8'
  pod 'ChameleonFramework/Swift'
  pod 'SwiftyUserDefaults', '2.2.1'
  pod 'FYLogger', '0.81.1'
  pod 'MJRefresh'
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
