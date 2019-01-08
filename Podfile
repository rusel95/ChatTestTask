platform :ios, '11.0'

abstract_target 'Shared' do
    use_frameworks!
    inhibit_all_warnings!
    
    # DI
    pod 'Swinject', '~> 2.5.0'
    pod 'SwinjectAutoregistration', '~> 2.5.0'
    
    # FRP
    pod 'RxCocoa', '~> 4.4.0'
    pod 'RxSwift', '~> 4.4.0'
    pod 'RxRealm', '~> 0.7.6'
    pod 'NSObject+Rx', '~> 4.4.1'

    target 'Core' do

  	# DB client component
    pod 'DBClient/Realm'
    
    # UI
    pod 'SideMenu', '~> 5.0'
    pod 'SnapKit', '~> 4.2.0'
    pod 'HandyText', '~> 1.4.0'
    pod 'fluid-slider'
    
    end
    
    target 'BrainFlowTimer' do
        # Controls
        pod 'SVProgressHUD', '~> 2.2.5'
        
        pod 'Kingfisher', '~> 4.10.1'
        
        # Tools
        pod 'SwiftGen', '~> 6.0.2'
    end
end

DEFAULT_SWIFT_VERSION = '4.2'
POD_SWIFT_VERSION_MAP = {
  'fluid-slider' => '4.2'
}

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    installer.pods_project.targets.each do |target|
        swift_version = POD_SWIFT_VERSION_MAP[target.name] || DEFAULT_SWIFT_VERSION
        puts "Setting #{target.name} Swift version to #{swift_version}"
        target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = swift_version
    end
  end
end
