#
# Be sure to run `pod lib lint NavyUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NavyUIKit'
  s.version          = '0.1.46'
  s.summary          = 'NavyUIKit 一组常用快速开发的UI框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
NavyUIKit 一组常用快速开发的UI框架。
NavyUIKit 一组常用快速开发的UI框架。
NavyUIKit 一组常用快速开发的UI框架。
                       DESC

  s.homepage         = 'http://10.11.156.200:51005/group/NavyKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Deju Liu' => 'cheneylew@163.com' }
  s.source           = { :git => 'http://10.11.156.200:51005/group/NavyKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
    #s.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/**/*'

    #non_arc_files = 'NavyUIKit/3rds/STKeychain/STKeychain.{h,m}'
    #s.subspec 'no-arc' do |noarc|
    #  noarc.requires_arc        = false
    #  noarc.source_files = non_arc_files
    #  noarc.compiler_flags = '-fno-objc-arc'
    #end

    s.subspec 'Categories' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/NavyKit/Categories/*.{h,m}'
    end

    s.subspec 'Utilities' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/NavyKit/Utilities/*.{h,m}'
    end

    s.subspec '3rds_DBImageView' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/3rds/DBImageView/*.{h,m}'
    end

    s.subspec '3rds_MBProgressHUD' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/3rds/MBProgressHUD/*.{h,m}'
    end

    s.subspec '3rds_KC_encryption' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/3rds/KC_encryption/*.{h,m}'
    end

    s.subspec '3rds_Toast' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/3rds/Toast/*.{h,m}'
    end

    s.subspec 'NavyCoreFundation' do |sp|
    sp.requires_arc        = true
    #sp.source_files = 'NavyUIKit/Classes/NavyKit/NavyCoreFundation/*'
    sp.dependency 'NavyUIKit/Categories'
    sp.dependency 'NavyUIKit/Utilities'
        sp.subspec 'Common' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyCoreFundation/Common/**/*'
        end
        sp.subspec 'Protocol' do |spsp|
            spsp.requires_arc        = true
            spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyCoreFundation/Protocol/**/*'
        end
        sp.subspec 'Models' do |spsp|
            spsp.requires_arc        = true
            spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyCoreFundation/Models/**/*'
            spsp.dependency 'NavyUIKit/NavyCoreFundation/Protocol'
        end
        sp.subspec 'Storage' do |spsp|
            spsp.requires_arc        = true
            spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyCoreFundation/Storage/**/*'
            spsp.dependency 'NavyUIKit/NavyCoreFundation/Protocol'
            spsp.dependency 'NavyUIKit/NavyCoreFundation/Models'
            spsp.dependency 'NavyUIKit/NavyCoreFundation/Common'
        end
        sp.subspec 'Categories' do |spsp|
            spsp.requires_arc        = true
            spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyCoreFundation/Categories/**/*'
            spsp.dependency 'NavyUIKit/NavyCoreFundation/Models'
            spsp.dependency 'NavyUIKit/NavyCoreFundation/Storage'
        end
    end

    s.subspec 'NavyCoreUIKit' do |sp|
    sp.requires_arc        = true
    sp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Categories/**/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Deploy/**/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Glass/**/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/H5Comunicator/**/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/MVVM/**/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/WebBrowser/**/*','NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/TableView/**/*'
    sp.dependency 'NavyUIKit/Categories'
    sp.dependency 'NavyUIKit/NavyCoreFundation'
    sp.dependency 'NavyUIKit/3rds_MBProgressHUD'
    sp.dependency 'NavyUIKit/3rds_KC_encryption'
    sp.dependency 'NavyUIKit/3rds_Toast'
    sp.dependency 'NavyUIKit/3rds_DBImageView'
        sp.subspec 'Macros' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Macros/**/*'
        end
        sp.subspec 'Utility' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Utility/**/*'
        end
        sp.subspec 'TextView' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/TextView/**/*'
        end
        sp.subspec 'ProcessHandler' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/ProcessHandler/**/*'
        end
        sp.subspec 'RemoteNotification' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/RemoteNotification/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreFundation/Common'
        end
        sp.subspec 'Layer' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Layer/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Macros'
        end

        sp.subspec 'Label' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Label/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Layer'
        end
        sp.subspec 'Button' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Button/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Label'
        end
        sp.subspec 'Picker' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Picker/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Macros'
        spsp.dependency 'NavyUIKit/NavyCoreFundation/Models'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Label'
        end
        sp.subspec 'AlertView' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/AlertView/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Label'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Picker'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Button'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Macros'
        end
        sp.subspec 'TextView' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/TextView/**/*'
        end
        sp.subspec 'TextField' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/TextField/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Macros'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Label'
        end
        sp.subspec 'Task' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Task/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Macros'
        spsp.dependency 'NavyUIKit/NavyCoreFundation/Common'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Label'
        spsp.dependency 'NavyUIKit/NavyCoreFundation/Models'
        end
        sp.subspec 'Menu' do |spsp|
        spsp.requires_arc        = true
        spsp.source_files = 'NavyUIKit/Classes/NavyKit/NavyUIKit/Classes/Menu/**/*'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Macros'
        spsp.dependency 'NavyUIKit/NavyCoreUIKit/Label'
        end

    end

  # s.resource_bundles = {
  #   'NavyUIKit' => ['NavyUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Security'                  #, 'CommonCrypto'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SAMKeychain', '~> 1.5.2'
  s.dependency 'DJMacros', '~> 0.7.8'
  s.dependency 'KKCategories', '~> 0.3.4'
end
