Pod::Spec.new do |s|
    s.name         = "KHealthTools"
    s.version      = "0.0.1"
    s.summary      = "Tools"
    
    s.description  = <<-DESC
    KHealthTools
    DESC
    
    s.license  = { :type => 'MIT', :file => 'LICENSE' }
    s.author   = { "liyunxin" => "447674668@qq.com" }
    s.homepage = "https://www.baidu.com"
    s.source   = { :git => "https://github.com/SSMouseGamer/KHealthTools.git", :tag => "#{s.version}" }
    
    #这个是处理.h导入第三方头文件报错
    s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
    
    s.platform   = :ios, "10.0"
    s.frameworks = 'UIKit'
    
    #工具类在这里
    s.subspec '1_Tools' do |st|
        st.source_files = "KHealthTools/1_Tools/*.{h,m}"
        st.subspec 'Tools' do |st_0|
          st_0.source_files = "KHealthTools/1_Tools/Tools/**/*.{h,m}"
        end
        st.subspec 'Category' do |st_1|
          st_1.source_files = "KHealthTools/1_Tools/Category/**/*.{h,m}"
        end
    end #1_Tools
    
    #分类在这里
    s.subspec '2_Category' do |sc|
        sc.dependency 'KHealthTools/1_Tools'
        sc.source_files = "KHealthTools/2_Category/**/*.{h,m}"
    end #2_Category
    
    #使用到的第三方库
    s.subspec '3_ThirdLib' do |st|
        st.subspec 'KHRefresh' do |st_refresh|
            st_refresh.dependency 'MJRefresh'
            st_refresh.source_files = "KHealthTools/3_ThirdLib/KHRefresh/**/*.{h,m}"
        end
        st.subspec 'UserDefault' do |st_userDefault|
            st_userDefault.source_files = "KHealthTools/3_ThirdLib/UserDefault/**/*.{h,m}"
        end
    end #3_ThirdLib
    
    #网络访问
    s.subspec '4_Services' do |ss|
        ss.dependency 'SDWebImage', '4.4.2'
        ss.dependency 'KHealthTools/1_Tools'
        ss.dependency 'KHealthTools/2_Category'
        ss.dependency 'KHealthTools/3_ThirdLib'
        ss.source_files = "KHealthTools/4_Services/*.{h,m}"
        ss.subspec '0_Config' do |ss_0|
          ss_0.source_files = "KHealthTools/4_Services/0_Config/**/*.{h,m}"
        end
        ss.subspec '1_Services' do |ss_1|
          ss_1.source_files = "KHealthTools/4_Services/1_Services/**/*.{h,m}"
        end
        ss.subspec '2_Task' do |ss_2|
          ss_2.source_files = "KHealthTools/4_Services/2_Task/**/*.{h,m}"
        end
        ss.subspec '3_SDWebImageExtend' do |ss_3|
          ss_3.source_files = "KHealthTools/4_Services/3_SDWebImageExtend/**/*.{h,m}"
        end
    end #4_Services
    
    #Model
    s.subspec '5_Model' do |sv|
      sv.source_files = "KHealthTools/5_Model/**/*.{h,m}"
    end #5_Model
    
    #View
    s.subspec '6_View' do |sv|
      sv.source_files = "KHealthTools/6_View/*.{h,m}"
      sv.subspec 'KHHUD' do |st_c|
        st_c.source_files = "KHealthTools/6_View/KHHUD/**/*.{h,m}"
      end
      sv.subspec 'KHEmptyView' do |st_e|
        st_e.source_files = "KHealthTools/6_View/KHEmptyView/**/*.{h,m}"
      end
      sv.subspec 'KHTableView' do |st_t|
        st_t.source_files = "KHealthTools/6_View/KHTableView/**/*.{h,m}"
      end
      sv.subspec 'KHButton' do |st_b|
        st_b.source_files = "KHealthTools/6_View/KHButton/**/*.{h,m}"
      end
    end #6_View
    
    #BaseController
    s.subspec '7_BaseController' do |sv|
      sv.dependency 'KHealthTools/4_Services'
      sv.dependency 'KHealthTools/5_Model'
      sv.dependency 'KHealthTools/6_View'
      sv.source_files = "KHealthTools/7_BaseController/**/*.{h,m}"
    end #7_BaseController
    
    #Controller
    s.subspec '7_Controller' do |sc|
      sc.dependency 'KHealthTools/7_BaseController'
      sc.subspec 'ListController' do |sc_list|
        sc_list.source_files = "KHealthTools/7_Controller/ListController/**/*.{h,m}"
      end
    end #6_Controller
    
    
    #PhotoManager
    s.subspec '8_PhotoManager' do |sv|
      sv.dependency 'KHealthTools/7_Controller'
      sv.source_files = "KHealthTools/8_PhotoManager/**/*.{h,m}"
    end #8_PhotoManager
    
    #功能
    s.subspec '9_Action' do |sc|
        sc.dependency 'KHealthTools/7_Controller'
        sc.subspec 'Calendar' do |sc_c|
          sc_c.source_files = "KHealthTools/9_Action/Calendar/**/*.{h,m}"
        end
        sc.subspec 'SetupFontScale' do |sc_sfs|
          sc_sfs.source_files = "KHealthTools/9_Action/SetupFontScale/**/*.{h,m}"
        end
        sc.subspec 'TimerManager' do |sc_t|
          sc_t.source_files = "KHealthTools/9_Action/TimerManager/**/*.{h,m}"
        end
    end #9_Action
    
    #头文件集结地
    s.subspec '0_Base' do |sb|
        sb.dependency 'KHealthTools/9_Action'
        
        sb.source_files = "KHealthTools/0_Base/**/*.{h,m}"
        sb.resource_bundles = {
            'KHealthTools' => ['KHealthTools/0_Base/*.xcassets']
        }
    end #0_Base
end #Pod::Spec

#本地：pod lib  lint --allow-warnings
#远端：pod spec lint --allow-warnings
#pod repo push KHealthSpecs KHealthTools.podspec --allow-warnings


