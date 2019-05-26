platform :ios, '10.3'

abstract_target 'Shared' do
    use_frameworks!
    inhibit_all_warnings!
    
    # DI
    pod 'Swinject', '~> 2.6.0'
    pod 'SwinjectAutoregistration', '~> 2.6.0'
    
    # FRP
    pod 'RxCocoa', '5.0.0'
    pod 'RxSwift', '5.0.0'
    pod 'RxGesture', '3.0.0'
    pod 'NSObject+Rx', '5.0.0'
    pod 'RxOptional', '4.0.0'

    target 'Core' do

    # DB client component
    pod 'RxRealm', '1.0.0'
    pod 'Alamofire'
    
    # Firebase
    pod 'Firebase/Core'
    
    # Char SDK
    pod 'Chatto', '= 3.4.0'
    pod 'ChattoAdditions', '= 3.4.0' # if you want to use the cells or the input component

    end
    
    target 'ChatTestTask' do
        # Controls
        pod 'SVProgressHUD', '~> 2.2.5'
        
        pod 'Kingfisher', '5.5.0'
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
