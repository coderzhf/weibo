//
//  WBComposeViewController.m
//  Weibo
//
//  Created by 张锋 on 15/5/13.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBComposeToolView.h"
#import "WBComposePhotoView.h"
#import "WBHttpTool.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WBComposeTool.h"
#import "WBEmotionKeyBoard.h"
@interface WBComposeViewController()<UITextViewDelegate,WBComposeToolViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,weak) UITextView *textView;
@property(nonatomic,weak)WBComposeToolView *toolView;
@property(nonatomic,weak)WBComposePhotoView *photoView;
@property(nonatomic,weak)WBEmotionKeyBoard *EmotionKeyBoard;
@property(nonatomic,assign)BOOL changingkeyboard;
@end
@implementation WBComposeViewController
#pragma mark 初始化方法
-(WBEmotionKeyBoard *)EmotionKeyBoard{
    if (_EmotionKeyBoard==nil) {
        _EmotionKeyBoard=[WBEmotionKeyBoard Keyboard];
        self.EmotionKeyBoard.frame=CGRectMake(0, 256, 320, 224);
        self.EmotionKeyBoard.backgroundColor=[UIColor greenColor];
    }
    return _EmotionKeyBoard;
}
-(void)viewDidLoad{
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加photosView
    [self setupPhotosView];
    
    // 添加toolbar
    [self setupToolbar];
    
}
#pragma mark 设置导航栏
-(void)setupNavBar{
    self.navigationItem.title=@"发微博";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(CancelClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发微博" style:UIBarButtonItemStylePlain target:self action:@selector(ComposeClick)];
}
#pragma mark 导航栏取消按钮
-(void)CancelClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 导航栏发微博
-(void)ComposeClick{
    if (self.photoView.TotalImages.count) {//有图片
        [self SendImageContext];
    }else{//无图片
        [self SendContext];
    }
    //关掉发送界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 无图片post请求
-(void)SendContext{
    
    WBComposeParam *param=[[WBComposeParam alloc]init];
    param.access_token=[WBAccountTool Account].access_token;
    param.status=self.textView.text;
    [WBComposeTool WBComposeWithParam:param success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}
#pragma mark 有图片post请求
-(void)SendImageContext{
    
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool Account].access_token;
    params[@"status"] = self.textView.text;
#warning 目前新浪开放的发微博接口 最多 只能上传一张图片 上传最后一张图片
    NSMutableArray *imageData=[NSMutableArray array];
    for (UIImage *image in self.photoView.TotalImages) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [imageData addObject:data];
    }
    // 2.发送POST请求
    [WBHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params dataArray:imageData success:^(id json) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}
#pragma mark添加编辑框
-(void)setupTextView{
    UITextView *textView=[[UITextView alloc]init];
    textView.font=[UIFont systemFontOfSize:18];
    textView.frame=self.view.frame;
    //竖直方向可以拖拽
    textView.alwaysBounceVertical=YES;
    [self.view addSubview:textView];
    textView.delegate=self;
    self.textView=textView;
    //设置键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark 键盘将要弹出
-(void)UIKeyboardWillShow:(NSNotification *)note{
    if (self.changingkeyboard) {
        self.changingkeyboard=NO;
        return;
    }
    //获取键盘改变的frame
    CGRect EndFrame =[note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat boardY=EndFrame.size.height;
    self.toolView.transform=CGAffineTransformMakeTranslation(0, -boardY);
    
}
#pragma mark 键盘将要隐藏
-(void)UIKeyboardWillHide:(NSNotification *)note{
    if (self.changingkeyboard) {
        return;
    }
    //回归原来的值
    self.toolView.transform=CGAffineTransformIdentity;
}
#pragma mark UITextViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView{
 
    [textView endEditing:YES];
}
#pragma mark 拖拽文本框
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // [self.textView resignFirstResponder];
    [self.textView endEditing:YES];
}
#pragma mark 添加工具栏
-(void)setupToolbar{
    WBComposeToolView *toolView=[[WBComposeToolView alloc]init];
    CGFloat ToolX=0;
    CGFloat ToolH=44;
    CGFloat ToolW=self.view.frame.size.width;
    CGFloat ToolY=self.view.frame.size.height-ToolH;
    toolView.frame=CGRectMake(ToolX, ToolY, ToolW, ToolH);
    [self.view addSubview:toolView];
    toolView.delegate=self;
    self.toolView=toolView;
  
}
#pragma mark WBComposeToolViewDelegate
-(void)WBComposeToolDidCLickButtonType:(WBComposeToolbarButtonType)type{
    switch (type) {
        case WBComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case WBComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case WBComposeToolbarButtonTypeEmotion:
            [self openEmotion];
            break;
        default:
            break;
    }
}
#pragma mark 打开相册
-(void)openAlbum{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    //photolibrary 相册
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    //可以进行编辑
    picker.allowsEditing=YES;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark 打开相机
-(void)openCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing=YES;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];

    }
}
#pragma mark 打开相机
-(void)openEmotion{
    self.changingkeyboard=YES;
    if (self.textView.inputView) {//切换到系统的键盘
        self.textView.inputView=nil;
        self.toolView.showEmotionButton=YES;
    }else{//切换到自定义键盘
        //如果临时换了键盘需要关闭键盘
        self.textView.inputView=self.EmotionKeyBoard;
        self.toolView.showEmotionButton=NO;
    }
    //注销第一响应
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //变成第一响应
        [self.textView becomeFirstResponder];
    });

}
#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取选中的照片
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.photoView ShowImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 初始化图片墙
-(void)setupPhotosView{
    WBComposePhotoView *photoView=[[WBComposePhotoView alloc]init];
    CGFloat photoY=180;
    CGFloat photoW=self.view.frame.size.width;
    CGFloat photoH=100;
    CGFloat photoX=0;
    photoView.frame=CGRectMake(photoX, photoY, photoW, photoH);
    [self.view addSubview:photoView];
    self.photoView=photoView;
}
#pragma mark 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
