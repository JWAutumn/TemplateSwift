source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

#修改为项目依赖方式
install! 'cocoapods', :generate_multiple_pod_projects => true
# 忽略引入库的所有警告
inhibit_all_warnings!

use_frameworks!

target 'TemplateSwift' do

  # autoLayout
  pod 'SnapKit'
  
  # networking
  pod 'Moya'
  # Image
  pod 'Kingfisher'

  # JSON
  pod 'SwiftyJSON'
  pod 'HandyJSON', '~> 5.0.1' # https://github.com/alibaba/HandyJSON
  
  # Objective-C
  pod 'MJRefresh'
  pod 'FDFullscreenPopGesture'
  pod 'DZNEmptyDataSet'
  pod 'MBProgressHUD', '~> 1.2.0' # https://github.com/jdg/MBProgressHUD

 # Keyboard
  pod 'IQKeyboardManagerSwift', '~> 6.0'  # https://github.com/hackiftekhar/IQKeyboardManager

  # Tools
  # 快速访问本地资源
  pod 'R.swift', '~> 5.0'  # https://github.com/mac-cain13/R.swift
  # 控制器
  pod 'JXSegmentedView'  # https://github.com/pujiaxin33/JXSegmentedView
  
  #  pod 'CocoaDebug', :configurations => ['Debug']

end
