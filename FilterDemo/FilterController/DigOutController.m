//
//  DigOutController.m
//  FilterDemo
//
//  Created by Jion on 2017/4/12.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "DigOutController.h"
#import "ZJDigOutFilter.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface DigOutController ()
{
    CIContext *myContext;
}
@property(nonatomic,strong)UIImageView  *imageView;

@end

@implementation DigOutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    ZJDigOutFilter *customFilter = [ZJDigOutFilter digOutFilter];
    
    [customFilter setValue:[[CIImage alloc] initWithImage:[UIImage imageNamed:@"img6.png"]] forKey:kCIInputImageKey];

   CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:[NSNumber numberWithBool:NO]}];
    
    CIImage *outCiImg = [customFilter valueForKey:kCIOutputImageKey];
    CGImageRef outputCGImage = [context createCGImage:outCiImg fromRect:[outCiImg extent]];
    
    self.imageView.image = [UIImage imageWithCGImage:outputCGImage];
    
   // [self multipleFilter:customFilter sourceImage:[UIImage imageNamed:@"img5.jpg"] bgImage:[UIImage imageNamed:@"img2.jpg"]];
}

-(void)multipleFilter:(CIFilter*)customFilter sourceImage:(UIImage*)source bgImage:(UIImage*)bgImage{
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
    
    [customFilter setValue:source forKey:kCIInputImageKey];
    
    CIImage *outCiImg = [customFilter valueForKey:kCIOutputImageKey];
    
    CIFilter *sourceOverCompositingFilter = [CIFilter filterWithName:@"CISourceOverCompositing"];
    [sourceOverCompositingFilter setValue:outCiImg forKey:kCIInputImageKey];
    [sourceOverCompositingFilter setValue:bgImage forKey:kCIInputBackgroundImageKey];
    CIImage *resutCiImg = [sourceOverCompositingFilter valueForKey:kCIOutputImageKey];
    
    CGImageRef outputCGImage = [myContext createCGImage:resutCiImg fromRect:[resutCiImg extent]];
    
    self.imageView.image = [UIImage imageWithCGImage:outputCGImage];
    
}

-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth);
        _imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
