//
//  ViewController.m
//  FilterDemo
//
//  Created by Jion on 2016/12/22.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ViewController.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *filterNames;
}
@property(nonatomic,strong)UIImageView  *imageView;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray  *sysFilters;
@property(nonatomic,strong)NSArray  *filterCategorys;
@property (nonatomic, strong) UIImage *orgImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"关于滤镜";
    
    filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    /*
    NSInteger index = 0;
    for (NSString *filterName in filterNames) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%ld == %@",++index, [fltr attributes]);
    }
    */
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    switchBtn.bounds = CGRectMake(0, 0, 60, 40);
    [switchBtn setTitle:@"切换" forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:switchBtn];
    
    [self showTableView];
}

-(void)switchBtnAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    UITableView *table = [self.view viewWithTag:110];
    if (sender.selected) {
        if (table) {
            table.hidden = YES;
        }
        self.pickerView.hidden = NO;
        self.imageView.hidden = NO;
        self.orgImage = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg",arc4random()%5+1]];
        self.imageView.image = self.orgImage;
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
    }else{
        self.pickerView.hidden = YES;
        self.imageView.hidden = YES;
        if (table) {
            table.hidden = NO;
        }
    }
}

-(void)showTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.tag = 110;
    tableView.delegate = self;
    tableView.dataSource = self;
   
    [self.view addSubview:tableView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [self setup];
}

#pragma mark--UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterCategorys.count+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    if (indexPath.row == self.filterCategorys.count) {
        cell.textLabel.text = @"复合滤镜";
        cell.detailTextLabel.text = nil;
    }else{
        NSDictionary *cellDic = self.filterCategorys[indexPath.row];
        cell.textLabel.text = cellDic[@"title"];
        cell.detailTextLabel.text = cellDic[@"subTitle"];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<self.filterCategorys.count) {
        id vc = [[NSClassFromString(@"FilterCategoryController") alloc] init];
        NSDictionary *cellDic = self.filterCategorys[indexPath.row];
        [vc setValue:cellDic[@"title"] forKey:@"filterCategoryName"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        id vc = [[NSClassFromString(@"StackFilterNameController") alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark --- line -----
-(void)singleFilterTest{
    self.orgImage = [UIImage imageNamed:@"img2.jpg"];
    
    CIContext *myContext = nil;
    
    BOOL isEAGL = arc4random()%2==1?YES:NO;
    if (isEAGL) {
        //一般的图像处理 kCIContextUseSoftwareRenderer YES在CPU渲染 NO在GPU渲染
        myContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:[NSNumber numberWithBool:NO]}];
    }else{
        
        //支持实时的图像处理
        EAGLContext *gLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
        [options setObject: [NSNull null] forKey: kCIContextWorkingColorSpace];
        myContext = [CIContext contextWithEAGLContext:gLContext options:options];
        
    }
    
    //CIImage配方对象
    CIImage *myCIImage = [CIImage imageWithCGImage:self.orgImage.CGImage];
    //创建滤镜
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setValue: myCIImage forKey: @"inputImage"];
    [hueAdjust setValue: [NSNumber numberWithFloat: 2.09]
                 forKey: @"inputAngle"];
    //图像输出
    CIImage *resultImage = [hueAdjust valueForKey: @"outputImage"];
    //图片修正
    CGRect rect;
    if (self.orgImage.imageOrientation == UIImageOrientationRight) {
        rect = CGRectMake(0, 0,self.orgImage.size.height , self.orgImage.size.width);
    }else{
        rect = CGRectMake(0, 0,self.orgImage.size.width , self.orgImage.size.height);
    }
    //渲染
    CGImageRef cgimage = [myContext createCGImage:resultImage fromRect:rect];
    self.imageView.image = [UIImage imageWithCGImage:cgimage scale:1.0 orientation:self.orgImage.imageOrientation];
    
}

-(void)setup{
    //这个性能好
    self.sysFilters = @[@"Original",
                        @"CILinearToSRGBToneCurve",
                        @"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade",
                        @"CIPhotoEffectInstant",
                        @"CIPhotoEffectMono",
                        @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess",
                        @"CIPhotoEffectTonal",
                        @"CIPhotoEffectTransfer",
                        @"CISRGBToneCurveToLinear",
                        @"CIVignetteEffect",
                                       ];

    self.imageView.hidden = YES;
    self.pickerView.hidden = YES;
    [self.view addSubview:self.imageView];
    
    [self.view addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row == 0) {
        /*
         UIImageOrientationUp,            // default orientation
         UIImageOrientationDown,          // 180 deg rotation
         UIImageOrientationLeft,          // 90 deg CCW
         UIImageOrientationRight,         // 90 deg CW
         UIImageOrientationUpMirrored,    // as above but image mirrored along other axis. horizontal flip
         UIImageOrientationDownMirrored,  // horizontal flip
         UIImageOrientationLeftMirrored,  // vertical flip
         UIImageOrientationRightMirrored,
         */
        self.imageView.image = self.orgImage;
        
        return;
    }
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        //子线程异步执行任务，防止主线程卡顿
        CIImage *ciImage = [CIImage imageWithCGImage:self.orgImage.CGImage];
        
        CIFilter *filter = [CIFilter filterWithName:self.sysFilters[row]
                            
                                      keysAndValues:kCIInputImageKey, ciImage, nil];
        
         CIContext *context = [CIContext contextWithOptions:nil];
        CGRect rect;
        if (self.orgImage.imageOrientation == UIImageOrientationRight) {
            rect = CGRectMake(0, 0,self.orgImage.size.height , self.orgImage.size.width);
        }else{
           rect = CGRectMake(0, 0,self.orgImage.size.width , self.orgImage.size.height);
        }
         CGImageRef cgImage = [context createCGImage:filter.outputImage
         fromRect:rect];
        UIImage *newImg = [UIImage imageWithCGImage:cgImage scale:1.0 orientation:self.orgImage.imageOrientation];
        
        //处理赋值
         CGImageRelease(cgImage);
        
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //异步返回主线程，根据获取的数据，更新UI
        dispatch_async(mainQueue, ^{
            self.imageView.image = newImg;
        });
    });
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.sysFilters.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.sysFilters[row];
}

-(NSArray*)filterCategorys{
    if (!_filterCategorys) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@{@"title":kCICategoryDistortionEffect,@"subTitle":@"扭曲效果，比如bump、hole"}];
        [array addObject:@{@"title":kCICategoryGeometryAdjustment,@"subTitle":@"几何调整，比如仿射变换、平切、透视转换"}];
        [array addObject:@{@"title":kCICategoryCompositeOperation,@"subTitle":@"合并操作，比如源覆、最小化、源在顶source atop、色彩混合"}];
        [array addObject:@{@"title":kCICategoryHalftoneEffect,@"subTitle":@"半色调效果，比如screen、line screen、hatched"}];
        [array addObject:@{@"title":kCICategoryColorAdjustment,@"subTitle":@"色彩调整，比如伽马调整、白点调整、曝光"}];
        [array addObject:@{@"title":kCICategoryColorEffect,@"subTitle":@"色彩效果，比如色调调整、posterize"}];
        [array addObject:@{@"title":kCICategoryTransition,@"subTitle":@"图像间翻转，比如dissolve、disintegrate with mask、swipe"}];
        [array addObject:@{@"title":kCICategoryTileEffect,@"subTitle":@"瓦片效果，比如parallelogram、triangle"}];
        [array addObject:@{@"title":kCICategoryGenerator,@"subTitle":@"图像生成器，比如stripes、constant color、checkerboard"}];
        [array addObject:@{@"title":kCICategoryReduction,@"subTitle":@"削减"}];
        [array addObject:@{@"title":kCICategoryGradient,@"subTitle":@"渐变，比如轴向渐变、仿射渐变、高斯渐变"}];
        [array addObject:@{@"title":kCICategoryStylize,@"subTitle":@"风格化，比如像素化、水晶化"}];
        [array addObject:@{@"title":kCICategorySharpen,@"subTitle":@"锐化、发光"}];
        [array addObject:@{@"title":kCICategoryBlur,@"subTitle":@"模糊，比如高斯模糊、焦点模糊、运动模糊"}];
        [array addObject:@{@"title":kCICategoryVideo,@"subTitle":@"用于视频"}];
        [array addObject:@{@"title":kCICategoryStillImage,@"subTitle":@"用于静态图像"}];
        [array addObject:@{@"title":kCICategoryInterlaced,@"subTitle":@"用于交叉图像"}];
        [array addObject:@{@"title":kCICategoryNonSquarePixels,@"subTitle":@"非方形像素"}];
        [array addObject:@{@"title":kCICategoryHighDynamicRange,@"subTitle":@"高动态范围,用于HDR"}];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0){
            [array addObject:@{@"title":kCICategoryFilterGenerator,@"subTitle":@"滤镜生成器"}];
        }
        
        _filterCategorys = array;
        
    }
    return _filterCategorys;
}

-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-200);
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

-(UIPickerView*)pickerView{
    if (!_pickerView) {
        UIPickerView *pickerView =[[UIPickerView alloc] init];
        pickerView.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
        pickerView.delegate = self;
        _pickerView = pickerView;
    }
    return _pickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
