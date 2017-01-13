//
//  PublicTool.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "PublicTool.h"
// 美颜
#import "GPUImageBeautifyFilter.h"


@interface PublicTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, AMapLocationManagerDelegate,AMapSearchDelegate>

//打开相册／相机页面
@property (nonatomic, strong) UIViewController *picController;

//美颜
@property (nonatomic, strong) GPUImageBeautifyFilter *beautifyFilter;// 美颜滤镜

@end

@implementation PublicTool

/** 懒加载 */
-(GPUImageBeautifyFilter *)beautifyFilter{//美颜
    
    if (!_beautifyFilter) {
        _beautifyFilter = [GPUImageBeautifyFilter new];
    }
    return _beautifyFilter;
}



/** 单例 */
+ (PublicTool *)shareInstance{
    
    static dispatch_once_t onceToken;
    static PublicTool * shareTools = nil;
    dispatch_once(&onceToken, ^{
        shareTools = [[PublicTool alloc]init];
        
    });
    return shareTools;
}


#pragma mark - ============ 1.系统类🔧 ============

#pragma mark - 获取当前version号，并转化成int类型, 例:@111
+(int) getVersionNum
{
    NSMutableString *str1 = [NSMutableString stringWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '"' || c == '.' || c == ',' || c == '(' || c == ')') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    
    NSString *newstr = [NSString stringWithString:str1];
    
    int versionNum = [newstr intValue];
    
    return versionNum;
}


/** 计算字符串长度*/
+(CGFloat)lengthofStr:(NSString *)str AndSystemFontOfSize:(CGFloat) fontSize{
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGSize size= [str sizeWithAttributes:attrs];
    return size.width;
    
}
/** 计算字符串高度*/
+(CGFloat)heightOfStr:(NSString *)str andTextWidth:(CGFloat)width andFont:(UIFont *)font{
    CGRect frame_H = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return frame_H.size.height;
}

#pragma mark - - 拨打电话☎️
+ (void)callPhoneWithPhoneNum:(NSString *)phoneNumberStr
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumberStr]] options:@{} completionHandler:nil];
}

/** 获取UUID */
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/** 获取时间戳 */
-(NSString *) getTime {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    return timeString;
}



/** 绘制圆形图片 */
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为0，颜色为无色
    
    CGContextSetLineWidth(context,0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}

#pragma mark - 压缩图片到指定尺寸大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
#pragma mark - 颜色转图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 首次打开app
+(int)isFirstOpenApp
{
    return [[UserDefault objectForKey:@"frist"] intValue];
    
}

#pragma mark - 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}
#pragma mark - 手机号处理－带星号
+(NSString *)setStartOfMumber:(NSString *)number{

    if(number.length == 11){
        //使用NSMutableString避免多次替换字符串中的字符而出现错误
        NSMutableString *strNum = [NSMutableString stringWithFormat:@"%@",number];
        [strNum replaceCharactersInRange:NSMakeRange(3,4) withString:@"****"];
        NSString *phoneNumber = [NSString stringWithString:strNum];
        
        return phoneNumber;
    }
    return nil;
}

#pragma mark - - 检测是否有网络
+ (BOOL)testNetworkIsConnected
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark - - 检测是否在WIFI环境下
+ (BOOL)testNetworkIsWifi
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

#pragma mark - - 发送通知
+(void)postNotificationWithName:(NSString *)nameStr object:(id)userInfoObject
{
    [[NSNotificationCenter defaultCenter]postNotificationName:nameStr object:nil userInfo:userInfoObject];
}

#pragma mark - - 接收通知
-(void)getNotificationWithName:(NSString *)nameStr object:(NotificationBlock)userInfoObjectBlock{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvBcast:) name:nameStr object:nil];
    
    _userInfoObjectBlock = userInfoObjectBlock;
    
}
- (void) recvBcast:(NSNotification *)notify{
    _userInfoObjectBlock(notify);
}

#pragma mark - - UTF8 字符转换
+ (NSString *)UTF8String:(NSString *)str
{
    NSString *changedStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return changedStr;
}

#pragma mark - 打开相册／相机，获取图片
-(void)putAlertViewWithViewController:(UIViewController *)selfViewCOntroller
                          andPicBlock:(PicBlock)picBlock{
    
    //拷贝页面
    self.picController = selfViewCOntroller;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择图片来源" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIImagePickerController * picController;
    if (picController == nil) {
        picController = [[UIImagePickerController alloc]init];
    }
    // 设置成为代理
    picController.delegate = self;
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相机
        //判断当前传入的这个多媒体类型是不是一个有效的类型 (判断是否允许使用，如果可以使用就打开摄像头）
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            picController.sourceType = UIImagePickerControllerSourceTypeCamera;//调用相机
            picController.cameraDevice = UIImagePickerControllerCameraDeviceFront;//调用前摄像头
            // 跳转到相机
            [selfViewCOntroller presentViewController:picController animated:YES completion:nil];
            
        }
        else
        {
            [selfViewCOntroller showHint:@"调用相机失败"];
        }
    }];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"相片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相册
        //判断一下这个相册类型是不是有效类型
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            //访问相册
            picController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 跳转到相册
            [selfViewCOntroller presentViewController:picController animated:YES completion:nil];
            
        }
        else
        {
            [selfViewCOntroller showHint:@"调用相册失败"];
        }
        
    }];
    
    picController.allowsEditing = YES;
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cameraAction];
    [alert addAction:picAction];
    [alert addAction:cancelAction];
    
    [selfViewCOntroller presentViewController:alert animated:YES completion:nil];
    
    _picBlock = picBlock;
    
}

#pragma mark - UIImagePickerController相片的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //所以先判断一下，取出来的是什么类型
    NSString * imageType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([imageType isEqualToString: (NSString *)kUTTypeImage]) {
        //如果类型为图片，那么以编辑的模式，取出来图片
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        //经过图片大小处理
        UIImage *sizeIMG = [self scaleToSize:image size:CGSizeMake(MATCHSIZE(200), MATCHSIZE(200))];
        //经过美颜图片
        NSObject *objValue = [CacheClass getAllDataFromYYCacheWithKey:Beautiful_KEY];
        if (objValue != nil) {
            NSInteger flag = [(NSString *)objValue integerValue];
            if(flag == 1){
                UIImage *beatiufyIMG = [self.beautifyFilter imageByFilteringImage:sizeIMG];
                if (_picBlock != nil) {
                    _picBlock(beatiufyIMG);
                }
            }else{
                if (_picBlock != nil) {
                    _picBlock(sizeIMG);
                }
            }
        }else{
            UIImage *beatiufyIMG = [self.beautifyFilter imageByFilteringImage:sizeIMG];
            if (_picBlock != nil) {
                _picBlock(beatiufyIMG);
            }
        }
       
    }
    
    //返回主页面
    [self.picController dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - 获取当前时间
+(NSString *)getCurrentTime{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13

    return currentDateStr;
}


#pragma mark 使用NSSearchPathForDirectoriesInDomains创建文件目录
- (void) createDir {
    
    // NSDocumentDirectory 沙盒 Documents 目录
    // NSLibraryDirectory  沙盒 Library   目录
    // NSCachesDirectory   沙盒 Library/Caches   目录
    // 使用NSSearchPathForDirectoriesInDomains只能定位Caches、Library、Documents目录,tmp目录，不能按照此方法获得
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:@"file"]; // 在指定目录下创建 "file" 文件夹
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) ) {
        
        // 在 Document 目录下创建一个 file 目录
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"创建文件夹成功");
    }
    
    NSLog(@"本地文件夹路径:%@",dataFilePath);
}

@end
