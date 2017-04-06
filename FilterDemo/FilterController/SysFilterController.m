//
//  SysFilterController.m
//  FilterDemo
//
//  Created by Jion on 2017/4/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "SysFilterController.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
@interface SysFilterController ()
{
   CIContext *myContext;
   CIFilter *currentFilter;
    UIImage *sourceImage;
}

@property(nonatomic,strong)UIImageView  *imageView;
@property(nonatomic,strong)NSMutableArray *numberArray;
@property(nonatomic,strong)NSMutableArray *vectorArray;
@end

@implementation SysFilterController
static  int number = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.filterName;
    [self.view addSubview:self.imageView];
    
    [self handleImg];
    
}

-(void)handleImg{
    
    currentFilter = [CIFilter filterWithName:_filterName];
    NSDictionary *attributes = currentFilter.attributes;
    NSLog(@"attributes == %@", attributes);
    NSString *message = @"";
    for (NSInteger i=0 ; i < currentFilter.inputKeys.count ; i++){
        NSString *key = currentFilter.inputKeys[i];
        id objc = [currentFilter.attributes valueForKey:key];
        if ([objc isKindOfClass:[NSDictionary class]]) {
            if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([NSNumber class])]) {
               UILabel *lable = [[UILabel alloc] init];
                lable.numberOfLines = 2;
                lable.frame = CGRectMake(5,CGRectGetMaxY(self.imageView.frame)+25*i-20, 100, 24);
                lable.tag = 100+i;
                lable.font = [UIFont systemFontOfSize:10];
                lable.textAlignment = NSTextAlignmentCenter;
                lable.text = [NSString stringWithFormat:@"%@:%@",key,[objc objectForKey:kCIAttributeDefault]];
                [self.view addSubview:lable];
                
               UISlider *slider = [[UISlider alloc] init];
                slider.frame = CGRectMake(CGRectGetMaxX(lable.frame)+5, CGRectGetMaxY(self.imageView.frame)+25*i-20,kScreenWidth - 120 , 20);
                slider.tag = 1000+i;
                slider.continuous = YES;
                //最小值
                slider.minimumValue = [objc objectForKey:kCIAttributeSliderMin]?[[objc objectForKey:kCIAttributeSliderMin] floatValue]:0;
                //最大值
                slider.maximumValue = [objc objectForKey:kCIAttributeSliderMax]?[[objc objectForKey:kCIAttributeSliderMax] floatValue]:100;
                //默认值
                slider.value = [[objc objectForKey:kCIAttributeDefault] floatValue];
                [slider addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
                [self.view addSubview:slider];
            }else if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([CIColor class])]){
                UILabel *lable = [[UILabel alloc] init];
                lable.frame = CGRectMake(5,CGRectGetMaxY(self.imageView.frame)+25*i-20, 100, 24);
                lable.numberOfLines = 2;
                lable.tag = 100+i;
                lable.font = [UIFont systemFontOfSize:10];
                lable.textAlignment = NSTextAlignmentCenter;
                lable.text = [NSString stringWithFormat:@"%@:%@",key,[objc objectForKey:kCIAttributeDefault]];
                [self.view addSubview:lable];
                
                CIColor *cicolor = [objc objectForKey:kCIAttributeDefault];
                
                CGFloat sliderW = (kScreenWidth - 120)/4.0;
                
                UISlider *sliderR = [[UISlider alloc] init];
                sliderR.frame = CGRectMake(CGRectGetMaxX(lable.frame)+5, CGRectGetMaxY(self.imageView.frame)+25*i-20, sliderW, 20);
                sliderR.tag = 1100+i;
                sliderR.continuous = YES;
                //最小值
                sliderR.minimumValue = 0;
                //最大值
                sliderR.maximumValue = 1.0;
                //默认值
                sliderR.value = [[NSString stringWithFormat:@"%.2f",cicolor.red] floatValue];
                [sliderR addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
                [self.view addSubview:sliderR];
                
                UISlider *sliderG = [[UISlider alloc] init];
                sliderG.frame = CGRectMake(CGRectGetMaxX(sliderR.frame)+2, CGRectGetMaxY(self.imageView.frame)+25*i-20,sliderW , 20);
                sliderG.tag = 1200+i;
                sliderG.continuous = YES;
                //最小值
                sliderG.minimumValue = 0;
                //最大值
                sliderG.maximumValue = 1.0;
                //默认值
                sliderG.value = [[NSString stringWithFormat:@"%.2f",cicolor.green] floatValue];
                [sliderG addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
                [self.view addSubview:sliderG];
                
                UISlider *sliderB = [[UISlider alloc] init];
                sliderB.frame = CGRectMake(CGRectGetMaxX(sliderG.frame)+2, CGRectGetMaxY(self.imageView.frame)+25*i-20,sliderW, 20);
                sliderB.tag = 1300+i;
                sliderB.continuous = YES;
                //最小值
                sliderB.minimumValue = 0;
                //最大值
                sliderB.maximumValue = 1.0;
                //默认值
                sliderB.value = [[NSString stringWithFormat:@"%.2f",cicolor.blue] floatValue];
                [sliderB addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
                [self.view addSubview:sliderB];
                
                UISlider *sliderA = [[UISlider alloc] init];
                sliderA.frame = CGRectMake(CGRectGetMaxX(sliderB.frame)+2, CGRectGetMaxY(self.imageView.frame)+25*i-20,sliderW , 20);
                sliderA.tag = 1400+i;
                sliderA.continuous = YES;
                //最小值
                sliderA.minimumValue = 0;
                //最大值
                sliderA.maximumValue = 1.0;
                //默认值
                sliderA.value =  [[NSString stringWithFormat:@"%.2f",cicolor.alpha] floatValue];
                [sliderA addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
                [self.view addSubview:sliderA];
                
                
            }else if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([CIVector class])]){
                
                message = [message stringByAppendingString:[NSString stringWithFormat:@"%@ = %@\n",key,objc]];
                
            }else if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([NSData class])]){
                message = [message stringByAppendingString:[NSString stringWithFormat:@"%@ = %@\n",key,objc]];
            }
        }
    }
    
    if (message.length>0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"这些参数需要单独处理" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }
    if (number>=5) {
        number = 1;
    }else{
        number++;
    }
    sourceImage = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg",number]];
    [self singleFilter:currentFilter sourceImage:sourceImage];
    
}

-(void)changeSlider:(UISlider*)sender{
    [self singleFilter:currentFilter sourceImage:sourceImage];
}

-(void)singleFilter:(CIFilter*)sysFilter sourceImage:(UIImage*)source{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
        
        //CIImage配方对象
        CIImage *myCIImage = [CIImage imageWithCGImage:source.CGImage];
        //设置滤镜
        for (NSInteger i=0 ; i < sysFilter.inputKeys.count ; i++) {
            NSString *key = sysFilter.inputKeys[i];
            id objc = [sysFilter.attributes valueForKey:key];
            if ([objc isKindOfClass:[NSDictionary class]]) {
                if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([CIImage class])]) {
                    
                    [sysFilter setValue: myCIImage forKey: key];
                    
                }else if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([NSNumber class])]){
                    UISlider *slider = [self.view viewWithTag:1000+i];
                    UILabel *showLabel = [self.view viewWithTag:100+i];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        showLabel.text = [NSString stringWithFormat:@"%@:%.2f",key,slider.value];
                        
                    });
                    
                    [sysFilter setValue:[NSNumber numberWithFloat:slider.value]  forKey: key];
                    
                }else if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([CIVector class])]){
                    [sysFilter setValue:[objc valueForKey:kCIAttributeDefault]  forKey: key];
                    
                }else if ([[objc valueForKey:kCIAttributeClass] isEqualToString:NSStringFromClass([CIColor class])]){
                    
                    UILabel *showLabel = [self.view viewWithTag:100+i];
                    
                    UISlider *sliderR = [self.view viewWithTag:1100+i];
                     UISlider *sliderG = [self.view viewWithTag:1200+i];
                    UISlider *sliderB = [self.view viewWithTag:1300+i];
                    UISlider *sliderA = [self.view viewWithTag:1400+i];
                    CGFloat r = [[NSString stringWithFormat:@"%.2f",sliderR.value] floatValue];
                    CGFloat g = [[NSString stringWithFormat:@"%.2f",sliderG.value] floatValue];
                    CGFloat b = [[NSString stringWithFormat:@"%.2f",sliderB.value] floatValue];
                    CGFloat a = [[NSString stringWithFormat:@"%.2f",sliderA.value] floatValue];
                    CIColor *cicolor = [CIColor colorWithRed:r green:g blue:b alpha:a];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        showLabel.text = [NSString stringWithFormat:@"%@:%@",key,cicolor];
                        
                    });
                    
                    [sysFilter setValue:cicolor  forKey: key];
                }
            }
            
        }
        /*
         [sysFilter setValue: myCIImage forKey: @"inputImage"];
         [sysFilter setValue: [NSNumber numberWithFloat: 2.09] forKey: @"inputAngle"];
         */
        
        //图像输出
        CIImage *resultImage = sysFilter.outputImage;
        //渲染
         dispatch_async(dispatch_get_main_queue(), ^{
             CGImageRef cgimage = [myContext createCGImage:resultImage fromRect:CGRectMake(0, 0, source.size.width, source.size.height)];
             
             self.imageView.image = [UIImage imageWithCGImage:cgimage scale:1.0 orientation:source.imageOrientation];
             CGImageRelease(cgimage);
         });

    });

    
}


-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth);
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

//解决拍照图片处理后旋转的问题
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
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