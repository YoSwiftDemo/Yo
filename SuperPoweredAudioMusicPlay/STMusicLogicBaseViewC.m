//
//  STMusicLogicBaseViewC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicLogicBaseViewC.h"

@interface STMusicLogicBaseViewC ()

@end

@implementation STMusicLogicBaseViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+( STMusicLogicBaseViewC *)showSTMusicLogicOnSuperViewC:(STMusicBaseViewC *)superViewC
                                            ofFrameRect:(CGRect)frameRect
                                        newViewCNameStr:(NSString *)newViewCNameStr
                                               complete:(void(^)(BOOL finished,
                                                                 STMusicLogicBaseViewC *newViewC))block{
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
    STMusicLogicBaseViewC *newViewC = [[newViewControllerClass alloc]initWithNibName:newViewCNameStr
                                                                              bundle:nil];
    //
    newViewC.recordSuperViewC = superViewC;
    //frame
    //ewViewC.view.frame = frameRect;
    //child
    [superViewC addChildViewController:newViewC];
    //[superViewC.view addSubview:newViewC.view];
    //block
    if (block) {
        block(YES,nil);
    }
    
    return newViewC;
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
