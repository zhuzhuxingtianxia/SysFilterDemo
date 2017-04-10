//
//  StackFilterController.m
//  FilterDemo
//
//  Created by Jion on 2017/4/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "StackFilterController.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface StackFilterController ()
{
    CIContext *myContext;
}
@property(nonatomic,strong)UIImageView  *imageView;
@property(nonatomic,strong)UIImage  *imageSoure;
@end

@implementation StackFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)multipleFilter:(CIFilter*)sysFilter sourceImage:(UIImage*)source{
    if (_isEAGL) {
        //支持实时的图像处理
        if (!myContext) {
            EAGLContext *gLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
            NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
            [options setObject: [NSNull null] forKey: kCIContextWorkingColorSpace];
            myContext = [CIContext contextWithEAGLContext:gLContext options:options];
        }
        
        
    }else{
        //一般的图像处理 kCIContextUseSoftwareRenderer YES在CPU渲染 NO在GPU渲染
        if (!myContext) {
            myContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:[NSNumber numberWithBool:NO]}];
        }
        
    }

}

-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth);
        _imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
