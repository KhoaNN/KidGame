//
//  Content.h
//  KidGame
//
//  Created by KhoaNN on 1/8/14.
//  Copyright (c) 2014 KHOA NGUYEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Title;

@interface Content : NSManagedObject

@property (nonatomic, retain) NSData * contentImage;
@property (nonatomic, retain) NSString * contentSound;
@property (nonatomic, retain) NSString * contentText;
@property (nonatomic, retain) Title *title;

@end
