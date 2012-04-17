//
//  PrettySearchBar.m
//  SearchDemo
//
//  Created by lijian qiu on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrettySearchBar.h"



@implementation PrettySearchBar

@synthesize searchBarTextField = _searchBarTextField;
@synthesize normalBackgroundImage,highlightBackgroundImage;

-(void)dealloc
{
	[_searchBarTextField release],_searchBarTextField = nil;
	[normalBackgroundImage release],normalBackgroundImage = nil;
	[highlightBackgroundImage release],highlightBackgroundImage = nil;
	[super dealloc];
}

-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.normalBackgroundImage = [UIImage imageNamed:@"searchFrame.png"];
		self.highlightBackgroundImage = [UIImage imageNamed:@"searchFrameHighlight.png"];
	}
	return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
	self.normalBackgroundImage = [UIImage imageNamed:@"searchFrame.png"];
	self.highlightBackgroundImage = [UIImage imageNamed:@"searchFrameHighlight.png"];
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	//get searchBar textField
	if ([self isFirstResponder]) {
		[self.searchBarTextField setBackground:highlightBackgroundImage];
	}else {
		[self.searchBarTextField setBackground:normalBackgroundImage];
	}
}


-(UITextField *)searchBarTextField
{
	if (_searchBarTextField == nil) {
		for (UIView *v in [self subviews]) {
			if ([v isKindOfClass:[UITextField class]]) {
				_searchBarTextField = [(UITextField *)v retain] ;
				UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchFrameBg.png"]] autorelease]; 
				[self insertSubview:imageView belowSubview:_searchBarTextField];
				return (UITextField *)v;
			}
		}
	}
	return _searchBarTextField;
}


@end
