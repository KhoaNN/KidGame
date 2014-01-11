//
//  Title.h
//  KidGame
//
//  Created by KhoaNN on 1/8/14.
//  Copyright (c) 2014 KHOA NGUYEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Content;

@interface Title : NSManagedObject

@property (nonatomic, retain) NSData * titleImage;
@property (nonatomic, retain) NSString * titleText;
@property (nonatomic, retain) NSSet *content;
@end

@interface Title (CoreDataGeneratedAccessors)

- (void)addContentObject:(Content *)value;
- (void)removeContentObject:(Content *)value;
- (void)addContent:(NSSet *)values;
- (void)removeContent:(NSSet *)values;

@end
