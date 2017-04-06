//
//  SysFilterController.h
//  FilterDemo
//
//  Created by Jion on 2017/4/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//
/*滤镜的分类 */
//kCICategoryVideo  kCICategoryStillImage kCICategoryInterlaced
//kCICategoryNonSquarePixels kCICategoryHighDynamicRange kCICategoryBuiltIn

/**CICategoryBlur  kCICategoryBlur**/
/*
 CIBoxBlur
 CIDiscBlur
 CIGaussianBlur
 CIMedianFilter
 CIMotionBlur
 CINoiseReduction
 CIZoomBlur
 */

/**CICategoryColorAdjustment kCICategoryColorAdjustment**/
/*
 CIColorControls
 CIColorMatrix
 CIExposureAdjust
 CIGammaAdjust
 CIHueAdjust
 CITemperatureAndTint
 CIToneCurve
 CIVibrance
 CIWhitePointAdjust
 */

/**CICategoryColorEffect kCICategoryColorEffect**/
/*
 CIColorCube
 CIColorInvert
 CIColorMap
 CIColorMonochrome
 CIColorPosterize
 CIFalseColor
 CIMaskToAlpha
 CIMaximumComponent
 CIMinimumComponent
 CISepiaTone

 */

/**CICategoryCompositeOperation kCICategoryCompositeOperation**/
/*
 CIAdditionCompositing
 CIColorBlendMode
 CIColorBurnBlendMode
 CIColorDodgeBlendMode
 CIDarkenBlendMode
 CIDifferenceBlendMode
 CIExclusionBlendMode
 CIHardLightBlendMode
 CIHueBlendMode
 CILightenBlendMode
 CILuminosityBlendMode
 CIMaximumCompositing
 CIMinimumCompositing
 CIMultiplyBlendMode
 CIMultiplyCompositing
 CIOverlayBlendMode
 CISaturationBlendMode
 CIScreenBlendMode
 CISoftLightBlendMode
 CISourceAtopCompositing
 CISourceInCompositing
 CISourceOutCompositing
 CISourceOverCompositing
 
 */

/**CICategoryDistortionEffect kCICategoryDistortionEffect**/
/*
 CIBumpDistortion
 CIBumpDistortionLinear
 CICircleSplashDistortion
 CICircularWrap
 CIDisplacementDistortion
 CIGlassDistortion
 CIGlassLozenge
 CIHoleDistortion
 CIPinchDistortion
 CITorusLensDistortion
 CITwirlDistortion
 CIVortexDistortion

 */

/**CICategoryGenerator kCICategoryGenerator**/
/*
 CICheckerboardGenerator
 CIConstantColorGenerator
 CILenticularHaloGenerator
 CIRandomGenerator
 CIStarShineGenerator
 CIStripesGenerator
 CISunbeamsGenerator
 */

/**CICategoryGeometryAdjustment  kCICategoryGeometryAdjustment**/
/*
 CIAffineTransform
 CICrop
 CILanczosScaleTransform
 CIPerspectiveTransform
 CIStraightenFilter

 */

/**CICategoryGradient  kCICategoryGradient**/
/*
 CIGaussianGradient
 CILinearGradient
 CIRadialGradient
 */

/**CICategoryHalftoneEffect kCICategoryHalftoneEffect**/
/*
 CICircularScreen
 CICMYKHalftone
 CIDotScreen
 CIHatchedScreen
 CILineScreen

 */

/**CICategoryReduction kCICategoryReduction**/
/*
CIAreaAverage
CIAreaHistogram
CIRowAverage
CIColumnAverage
CIAreaMaximum
CIAreaMinimum
CIAreaMaximumAlpha
CIAreaMinimumAlpha
*/

/**CICategorySharpen kCICategorySharpen**/
/*
CISharpenLuminance
CIUnsharpMask
*/

/**CICategoryStylize  kCICategoryStylize**/
/*
CIBlendWithMask
CIBloom
CIComicEffect
CICrystallize
CIEdges
CIEdgeWork
CIGloom
CIHeightFieldFromMask
CIHexagonalPixellate
CIHighlightShadowAdjust
CILineOverlay
CIPixellate
CIPointillize
CIShadedMaterial
CISpotColor
CISpotLight
*/

/**CICategoryTileEffect kCICategoryTileEffect**/
/*
CIAffineClamp
CIAffineTile
CIEightfoldReflectedTile
CIFourfoldReflectedTile
CIFourfoldRotatedTile
CIFourfoldTranslatedTile
CIGlideReflectedTile
CIKaleidoscope
CIOpTile
CIParallelogramTile
CIPerspectiveTile
CISixfoldReflectedTile
CISixfoldRotatedTile
CITriangleTile
CITwelvefoldReflectedTile
*/

/**CICategoryTransition kCICategoryTransition**/
/*
CIBarsSwipeTransition
CICopyMachineTransition
CIDisintegrateWithMaskTransition
CIDissolveTransition
CIFlashTransition
CIModTransition
CIPageCurlTransition
CIRippleTransition
CISwipeTransition
*/

#import <UIKit/UIKit.h>

@interface SysFilterController : UIViewController
@property(nonatomic,copy)NSString  *filterName;
//是否使用实时图像处理
@property(nonatomic,assign)BOOL isEAGL;
@end
