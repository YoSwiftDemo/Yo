//
//  STMusicBaseViewC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicBaseViewC.h"

@interface STMusicBaseViewC ()

@end

@implementation STMusicBaseViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * @brief:     创建新的音乐功能层ViewC(ViewC作为子ViewC)
 *
 * @discussion:1.作为子ViewC
 *             2.写在在基础类，供所有子类调用
 *             3.
 */
+(STMusicBaseViewC *)showSTMusicFunctionViewCOnSuperViewC:(UIViewController *)superViewC
                                              ofFrameRect:(CGRect)frameRect
                                          newViewCNameStr:(NSString *)newViewCNameStr
                                                 complete:(void(^)(BOOL finished,
                                                                   STMusicBaseViewC *newViewC))block{
    //superViewC
    if (!superViewC) {
        if(block){
            block(YES,nil);
        }
        return nil;
    }
    //clear
    for (UIViewController *oneViewC in superViewC.childViewControllers) {
        if ([oneViewC isKindOfClass:[self class]]) {
            [oneViewC removeFromParentViewController];
            [oneViewC.view removeFromSuperview];
        }
    }
    //class
    Class newViewControllerClass = NSClassFromString(newViewCNameStr);
    //new
    STMusicBaseViewC *newViewC = [[newViewControllerClass alloc]initWithNibName:newViewCNameStr
                                                                         bundle:nil];
    //
    newViewC.recordSuperViewC = superViewC;
    //frame
    newViewC.view.frame = frameRect;
    //child
    [superViewC addChildViewController:newViewC];
    [superViewC.view addSubview:newViewC.view];
    
    //block
    if (block) {
        block(YES,nil);
    }
    
    return newViewC;
}
/**
 * @brief:     创建新的音乐功能层ViewC(push 到 ViewC)
 *
 * @discussion:1.作为子ViewC
 *             2.写在在基础类，供所有子类调用
 *             3.
 */
+(STMusicBaseViewC *)pushSTMusicFunctionViewCOnSuperViewC:(UIViewController *)superViewC
                                              ofFrameRect:(CGRect)frameRect
                                          newViewCNameStr:(NSString *)newViewCNameStr
                                                 complete:(void(^)(BOOL finished,
                                                                   STMusicBaseViewC *newViewC))block{
    //superViewC
    if (!superViewC) {
        if(block){
            block(YES,nil);
        }
        return nil;
    }
    //class
    Class newViewControllerClass = NSClassFromString(newViewCNameStr);
    //new
    STMusicBaseViewC *newViewC = [[newViewControllerClass alloc]initWithNibName:newViewCNameStr
                                                                         bundle:nil];
    //
    newViewC.recordSuperViewC = superViewC;
    //frame
    newViewC.view.frame = frameRect;
    //child
    [superViewC addChildViewController:newViewC];
    [superViewC.view addSubview:newViewC.view];
    //block
    if (block) {
        block(YES,nil);
    }
    
    return newViewC;
}


-(UIViewController *)recordChildLogicViewC{
    return nil;
}





#pragma mark - pan手势拖动音乐ViewC（重写get）
/**
 * @brief:pan手势拖动音乐ViewC
 *
 *@discussion：1.需要重写get
 */
-(UIPanGestureRecognizer *)panGestureRecognizer{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerClick:)];
        [self.view addGestureRecognizer:_panGestureRecognizer];
    }
    return _panGestureRecognizer;
}
#pragma mark - pan手势执行方法
/**
 * @brief:pan手势执行方法
 *
 *@discussion：1.需要 记录的音乐ViewC的父ViewC
 */
- (void)panGestureRecognizerClick:(UIPanGestureRecognizer *)sender {
    CGPoint panPoint = [sender locationInView:self.recordSuperViewC.view];
    CGPoint panPoint_moveValue = [sender translationInView:self.recordSuperViewC.view];
    [self  setPanGesForYunMusicVC:panPoint
                    withModeValue:panPoint_moveValue];
    
}
#pragma mark - 坐标处理
/**
 * @brief:坐标处理
 *
 *@discussion：沿用悬浮直播里的处理
 */
-(void)setPanGesForYunMusicVC:(CGPoint)panPoint withModeValue:(CGPoint)moveVlue {
    self.view.transform = CGAffineTransformTranslate( self.view.transform, moveVlue.x, moveVlue.y);
    [_panGestureRecognizer setTranslation:CGPointZero inView:self.view];
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    }
    if (_panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    }
    if (_panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // 当向左边滑动
        if(self.view.x<0){
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.view.x =0;
                             }
                             completion:^(BOOL finished) {
                             }];
        }
        if(self.view.frame.origin.y<50){
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.view.y =50;
                             }
                             completion:^(BOOL finished) {
                             }];
        }
        if(self.view.frame.origin.y> SCREEN_HEIGHT/2){
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.view.y = SCREEN_HEIGHT/2;
                             }
                             completion:^(BOOL finished) {
                             }];
        }
        if(self.view.x>SCREEN_WIDTH/3){
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.view.x = SCREEN_WIDTH/3;
                             }
                             completion:^(BOOL finished) {
                                 
                             }];
            
        }
        
    }
    
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
