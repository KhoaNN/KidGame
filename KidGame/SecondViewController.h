//
//  SecondViewController.h
//  KidGame
//
//  Created by KhoaNN on 1/9/14.
//  Copyright (c) 2014 KHOA NGUYEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SecondViewController : UICollectionViewController {
    NSMutableArray *arrayImage;
    NSMutableArray *arrayTitle;
    NSMutableArray *arraySound;
    AVAudioPlayer *audioPlayer;
}

@property (strong, nonatomic) NSString *idTitle;

@end
