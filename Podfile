platform :ios, '10.3'

abstract_target 'Shared' do
    use_frameworks!
    inhibit_all_warnings!
    
    # DI
    pod 'Swinject', '~> 2.6.0'
    pod 'SwinjectAutoregistration', '~> 2.6.0'
    
    # FRP
    pod 'RxCocoa', '~> 4.5.0'
    pod 'RxSwift', '~> 4.5.0'
    pod 'NSObject+Rx', '~> 4.4.1'

    target 'Core' do

    # DB client component
    pod 'RxRealm'

    end
    
    target 'Buyper' do
        # Controls
        pod 'SVProgressHUD', '~> 2.2.5'
        
        pod 'Kingfisher', '~> 4.10.1'
        pod 'SnapKit', '~> 5.0.0'
        # Tools
        pod 'SwiftGen', '~> 6.1.0'
    end
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
