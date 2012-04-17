//
//  PrettySearchBar.h
//  SearchDemo
//
//  Created by lijian qiu on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrettySearchBar : UISearchBar

@property (nonatomic, retain) UITextField *searchBarTextField;
@property (nonatomic, retain) UIImage* normalBackgroundImage;
@property (nonatomic, retain) UIImage* highlightBackgroundImage;

@end
