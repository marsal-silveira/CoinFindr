source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'CoinFindr' do
    
  #Localizable
  pod 'R.swift'
  
  #Layout
  pod 'Cartography'

  #Lint
  pod 'SwiftLint'
  
  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'

  #API
  pod 'Moya-ObjectMapper/RxSwift'
    
  swift4 = [
    'R.swift',
    'Cartography',
    'Rswift',
    'RxSwift',
    'RxCocoa',
    'Alamofire',
    'Moya',
    'Moya-ObjectMapper',
    'ObjectMapper'
  ]
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      swift_version = nil
      
      if swift4.include?(target.name)
        swift_version = '4.0'
        else
        swift_version = '3.2'
      end
      
      if swift_version
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = swift_version
          config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
        end
      end
    end
  end
  
end

target 'CoinFindrTests' do
  
end

target 'CoinFindrUITests' do

end