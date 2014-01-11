//
//  SecondViewController.m
//  KidGame
//
//  Created by KhoaNN on 1/9/14.
//  Copyright (c) 2014 KHOA NGUYEN. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController {
    int level;
    int cardsOfLevel;
}

@synthesize idTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    level = 1;
    
    if (level == 1) {
        cardsOfLevel = 2;
    } else if (level == 2) {
        cardsOfLevel = 3;
    } else if (level == 4) {
        cardsOfLevel = 5;
    }
    
    arrayImage = [[NSMutableArray alloc]init];
    arrayTitle = [[NSMutableArray alloc]init];
    arraySound = [[NSMutableArray alloc]init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    NSError *error = nil;
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    NSDictionary *t = (NSDictionary *) [json objectForKey:idTitle];
    
    NSArray *cards = (NSArray *)[t objectForKey:@"cards"];
    
    
    NSMutableSet * numberSet = [NSMutableSet setWithCapacity:cardsOfLevel];
    while ([numberSet count] < cardsOfLevel ) {
        NSNumber * randomNumber = [NSNumber numberWithInt:(arc4random() % cards.count + 1)];
        [numberSet addObject:randomNumber];
    }
    
    NSArray * numbers = [numberSet allObjects];
   
    for (int i = 0; i < numbers.count; i++) {

        NSDictionary *cardsDict = (NSDictionary *)[cards objectAtIndex:[[numbers objectAtIndex:i] intValue]-1];
        NSString *src = (NSString *)[cardsDict objectForKey:@"src"];
        NSLog(@"Cards src: %@",src);
        
        NSDictionary *titleCardsDict = (NSDictionary *)[cardsDict objectForKey:@"title"];
        NSString *titleCards = (NSString *)[titleCardsDict objectForKey:@"vn"];
        NSLog(@"Cards title: %@",titleCards);
        
        NSString *sound = (NSString *)[cardsDict objectForKey:@"id"];
        NSLog(@"%@",sound);
        
        [arrayImage addObject:[NSString stringWithFormat:@"%@",src]];
        [arrayTitle addObject:[NSString stringWithFormat:@"%@",titleCards]];
        [arraySound addObject:[NSString stringWithFormat:@"%@",sound]];
        
    }

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayTitle.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SecondCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:102];
    imageView.image = [UIImage imageNamed:[arrayImage objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel *)[cell viewWithTag:103];
    label.text = [arrayTitle objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    level = level +1;
    NSLog(@"Level: %d",level);
    NSURL* audioFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:[NSString stringWithFormat:@"%@_vn",[arraySound objectAtIndex:indexPath.row]]
                                               ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFile error:nil];
    [audioPlayer play];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
