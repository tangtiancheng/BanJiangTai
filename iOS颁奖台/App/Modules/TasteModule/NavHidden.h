//
//  NavHidden.h
//  tastevendor
//
//  Created by 张帅 on 16/5/25.
//  Copyright © 2016年 com. All rights reserved.
//

#define  navHiddenY  self.navigationController.navigationBarHidden = YES;\
[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];

#define  navHiddenN  self.navigationController.navigationBarHidden = NO;\
[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];