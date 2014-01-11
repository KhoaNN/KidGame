//
//  FirstViewController.h
//  KidGame
//
//  Created by KhoaNN on 1/6/14.
//  Copyright (c) 2014 KHOA NGUYEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UICollectionViewController {
    NSMutableArray *arrayImage;
    NSMutableArray *arrayTitle;
}
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *fetchedRecordsArray;

//@property (strong, nonatomic) NSDictionary *json;

@end
