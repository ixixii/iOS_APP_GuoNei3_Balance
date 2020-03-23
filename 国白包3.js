deployment target: 10.3
直机运行时黑屏，报错：
[Application] The app delegate must implement the window property if it wants to use a main storyboard file.
解决办法：
AppDelegate中未声明"@property (strong, nonatomic) UIWindow * window;"
-----------------------------

todo list 0: 绑定自己的手机号 √
拿到国内开发者账号后，
登陆https://appleid.apple.com/
索取验证码
进入后，点击安全 -> 添加受信任的电话号码 
接着，生成App上传密码：xxx-yyy-zzz（后面使用Application Loader上传ipa包到appstore时要用到）

todo list 1: 退出旧的开发者账号  √
1.1 退出developer.apple.com上中国区的开发者账号 
    重新登陆developer.apple.com/account/ios/profile/limited/create
    会向第0步里的电话号码发送验证码

    退出itunesconnect  
    重新登陆 https://itunesconnect.apple.com/

    退出xcode上的开发者账号（xcode一直别登陆开发者账号，调试就用模拟器，打包就用描述文件 ）

1.2 开发者网站上面 创建证书  √
    1.打开Mac系统的 钥匙串访问 -> 左上角菜单：证书助理 -> 从证书颁发机构获取证书
      创建csr文件，选择存到磁盘
      常用名称：Multiple Alphabet
      邮箱写appleid的那个就行

    2.创建开发证书dev 和 生产证书dis
    3.下载证书，双击导入

// 1.3 添加真机设备？算了，直接用模拟器算了 （可以略过） 

1.4 开发者网站上，创建应用ID，即注册appid 
    net.vwhm.kibatina (瞎.J.B.乱取的)

// 1.5 创建描述文件？算了，直接用模拟器算了 （可以略过） 

1.6 使用net.vwhm.shinchan进行真机调试

1.7 使用shimo.im 进行隐私政策
模板：https://shimo.im/docs/KhyCkhyQvrCGqCcP/read


【KIBATINA】
https://shimo.im/docs/9VkCcCcVXtgGvDcT/read

    此时，再将url地址 https://shimo.im/docs/9VkCcCcVXtgGvDcT/read，填回itunesconnect
--------------------------
todo list 3: Logo √
    在线Logo设计网站：http://www.uugai.com/
    下载logo，改成正方形尺寸，
    再上传到bigjpg.com进行无损放
    再下载后，改成1024*1024标准尺寸

    然后一键生成所有图标：http://icon.wuruihong.com/
    下载并解压


todo list 4: 新建xcode工程，create a new project √
			 选择Tapped App
			 Product name:  (跟前面的appid一致)
             修改Info.plst: 
             存放到：/usr/beyond/iOS_APP/国白包3

             然后先关闭xcode

todo list 5: 复制podfile，√
             修改target为 alphabet
             然后执行pod install 
             打开alphabet.xcworkspace，


todo list 6: 将Assets.xcassets里原来的Appicon右键删除  √
             将前面第3步解压后的 AppIcon.appiconset 拖进来
             运行到模拟器上iPhone8   

todo list 7: 用导航控制器把viewController包装起来后；再把导航控制器设置为tabBarController的子控制器之一
             tabBarItem图标

todo list 8:
Assets.xcassets 新建一个imageSet: tab_me_default 和 tab_me

将2倍图，3倍图，拖进来;
高亮的选为Render As设置为!_Original Image_!

TabBarItem图标： (注意四周不要有透明像素)
tab_me_default@2x.png 50*50
tab_me_default@3x.png 75*75
默认：灰色, （144,144,144）     #909090


tab_icon_me@2x.png 50*50
tab_icon_me@3x.png 75*75
高亮：黄色：（253，176，72）     #FDB048


在xcode里面找到我们所对应的selectedImage图片,在最右边有个属性
我们将其选为Render As设置为Original Image就可以,不需要我们在自己手写代码进行
这样，tabbar icon高亮时的颜色就是 图片的颜色了，而不是系统默认的蓝色


todo list 9:
设置tab bar 高亮时，文字颜色 为 非蓝色

在【我的】控制器 -> viewDidLoad方法中：
    // 设置tab bar text 高亮时，文字颜色
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:kColor(253, 176, 72), UITextAttributeTextColor, nil];
    [self.xib_tabBarItem setTitleTextAttributes:tmpDict forState:UIControlStateHighlighted];
    // 这儿注意：拉线，@property (nonatomic,weak) IBOutlet UITabBarItem *xib_tabBarItem;
    // #define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

todo list 10: 自定义导航栏最快的办法是： 自定义导航控制器
自定义一个导航控制器，MyNavigationController
viewDidLoad方法中：

// 导航背景颜色
[self.navigationBar setBackgroundImage:[UIImage imageWithColor:kColor(253, 176, 72)] forBarMetrics:(UIBarMetricsDefault)];

// 统一设置，导航栏文字 颜色 
[self.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont systemFontOfSize:20],
      NSForegroundColorAttributeName:[UIColor orangeColor]}];



todo list 11: 导航右侧 添加按钮 UIButton
设置按钮的bgImg，仍然使用的是img set
navi_add@3x.png 72*72
navi_add@2x.png 48*48



KIBATINA是我们公司制作的家庭收支记录app，可以记录家人们的收入、支出及明细，方便您整理家庭账务，更好地进行管理，帮您养成良好的消费习惯，不会因为开支不清而烦恼，需要回溯时，打开我们的收支记录app就可以轻松地查看您的收支明细。

todo list 12: 登陆页面的
背景图，想要全屏，需要将top设置为 -20

todo list 13: 图片xib中设置圆角
Key Path
cornerRadius : Number  10
masksToBounds: Boolean Yes

todo list 14: 密码输入框 

UItextField 的密码模式
1.在XIB中实现：

将UITextField中的secure选项勾中即可。

2.通过代码实现：

UItextField * test = [ UItextField alloc] init ];

test.secureTextEntry = YES;




todo list 6: 打开pod工程，开始编码和测试  √
6.1 把appicon图片拖进来，Assets.xcassets 
    设置只支持iPhone且竖屏 
6.3 打开main.storyboard，
    // 默认图标，选中图标
    // 在iconfont上找图标，下载svg，通过Sketch导出为@2x @3x图标
    // Tab图标设计规范 https://www.jianshu.com/p/0ce2d11ef195
    // 75*75 @3x
    // 50*50 @2x
6.4 打开启动界面 LaunchScreen.storyboard， 
    修改设备尺寸为： iPhone8
    加一个图标log和一个文字 
    LaunchScreen.xib加一个imageView
    90*90,距离顶边120，垂直居中
    新建一个目录：图片
    把appicon@3x.png（180*180px）拖到Resources目录里，以供imageView引用     

6.5 设置顶部的状态条Status Bar Style 为 light content 
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
} 
6.8 开始实现第1个页面中的代码 
背影图片 高斯模糊 调整配色
http://www.peise.net/tools/web/  三角形配色

6.9 需要联网
报错：NSLocalizedDescription=The resource could not be loaded because the App Transport Security policy requires the use of a secure connection.}
解决办法1： 通过python脚本把所有的音频都下载下来 ——强烈推荐
解决办法2： 更改项目的App Transport Security policy __不推荐
打开info.plist, 右键 -> open as -> source code
<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
        <key>NSExceptionDomains</key>
        <dict>
            <key>yourdomain.com</key>
            <dict>
                <key>NSIncludesSubdomains</key>
                <true/>
                <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
                <false/>
            </dict>
       </dict>
  </dict>
--------------------------    
todo list 2: 因为开发者官网 与 itunesconnect不能实时同步， √
             所以，这次就先跳过itunesconnect那一步

todo list 2: 转到itunesconnect创建应用 
            (开发者网站上注册appid后，不一定itunesconnect会实时更新)
    转到itunesconnect,创建应用,新建app
    起名：多国字母 （可能会提示名称已被注册）
    主要语言：英文
    APP ID:net.vwhm.alphabet
    SKU: sku_multi_alphabet
    名称：多国字母
    副标题：
    类别：教育/工具
    价格：免费
    年龄分级：4+
    此时，再将隐私政策的url地址 http://vwhm.net/app/multiplealpha/privacy.html，填回itunesconnect
-------------------------- 
todo list 9: 尾声，上传项目源代码到git 
新建 .gitignore
在里面写上Pods
表示Pods目录不需要git来管理,因为它是pod install自动生成的

git init
git add --all
git commit -m 'iOS 国内区白包3 家庭收支管理 第一次提交'
git remote add origin https://github.com/ixixii/iOS_APP_GuoNei3_Balance.git
git push -u origin master
git push origin master
--------------------------

todo list 7: 打包ipa，Xcode不用登陆开发者账号，使用distribution provisoning file就行

            使用Application uploder上传ipa 
            打包上传时，不用XCODE，而是推荐使用Application uploder，但是需要用app专用密码登陆才行
            url: https://appleid.apple.com/

            版权：

todo list 8: 8种语言本地化 后，提交苹果审核
            关键词，记得要填写

            技术支持网址：vwhm.net

            英文美国

todo list 10: 清理战场
    注销Application uploader, 
    developer.apple.com
    https://appstoreconnect.apple.com/login

    准备登陆下一个账号，写第2个国内白包         