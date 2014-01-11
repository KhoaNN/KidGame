//
//  FirstViewController.m
//  KidGame
//
//  Created by KhoaNN on 1/6/14.
//  Copyright (c) 2014 KHOA NGUYEN. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "Title.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

int selectItem;

@implementation FirstViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2_portrait.jpg"]];
//    arrayImage = [NSArray arrayWithObjects:@"1-dong-vat.jpg", @"2-mau-sac.jpg", nil];
//    arrayText = [NSArray arrayWithObjects:@"Động vật", nil];
    
    
    ////////// CORE DATA ///////////////
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    self.managedObjectContext = appDelegate.managedObjectContext;
//    
//    self.fetchedRecordsArray = [[appDelegate getAllTitle] mutableCopy];
//    
//    if ([self.fetchedRecordsArray count] == 0) {
//        [self AddDataToCoreData];
//    }
    ///////////////////////////////////
    
    
    
    
    ////////// JSON /////////////
    // Retrieve local JSON file called example.json
    arrayImage = [[NSMutableArray alloc]init];
    arrayTitle = [[NSMutableArray alloc]init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    NSError *error = nil;
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    for (int i=1; i <= json.count ; i++) {
     
        NSDictionary *t = (NSDictionary *) [json objectForKey:[NSString stringWithFormat:@"%d",i]];
    
        NSString *src = (NSString *)[t objectForKey:@"src"];
        NSLog(@"src: %@",src);
        
        NSDictionary *titleDict = (NSDictionary *)[t objectForKey:@"title"];
        NSString *title = (NSString *)[titleDict objectForKey:@"vn"];
        NSLog(@"title: %@",title);
        
        [arrayImage addObject:[NSString stringWithFormat:@"%@",src]];
        [arrayTitle addObject:[NSString stringWithFormat:@"%@",title]];
        
    }
    ///////////////////////////////
    
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation
{
    // Set UIWebView Background Image
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        // code for Portrait orientation
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2_portrait.jpg"]];
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        // code for landscape orientation
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2_landscape.jpg"]];
    }
}

- (void)AddDataToCoreData {
    
    Title *title = [NSEntityDescription insertNewObjectForEntityForName:@"Title" inManagedObjectContext:self.managedObjectContext];

    NSString *txt = @"Động vật";
    UIImage *img = [UIImage imageNamed:@"1-dong-vat.jpg"];
    NSData *image = UIImagePNGRepresentation(img);
    
    [title setValue:txt forKey:@"titleText"];
    [title setValue:image forKey:@"titleImage"];
    
//    arrayImage = [NSArray arrayWithObjects:@"1-dong-vat.jpg", @"2-mau-sac.jpg", nil];
//    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:arrayImage];
//    [title setValue:arrayData forKey:@"titleImage"];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSLog(@"Saved");
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.fetchedRecordsArray = [[appDelegate getAllTitle] mutableCopy];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [arrayImage count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    //////////// CORE DATA ///////////////
//    Title *title = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
//    
//    [self.labelTitle setText:[NSString stringWithFormat:@"%@",[title valueForKey:@"titleText"]]];
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
//    imageView.image = [UIImage imageWithData:[title valueForKey:@"titleImage"]];
    
    
    
    
    ///////JSON ///////////////////////////
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
//    
//    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
//    
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
//    
//    NSInteger count = indexPath.item + 1;
//    
//    NSDictionary *t = (NSDictionary *) [json objectForKey:[NSString stringWithFormat:@"%d",count]];
//    
//    NSString *src = (NSString *)[t objectForKey:@"src"];
//    NSLog(@"src: %@",src);
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:[arrayImage objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    label.text = [arrayTitle objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectItem = indexPath.item;
    [self performSegueWithIdentifier:@"showContent" sender:self];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SecondViewController *secondVC = (SecondViewController *)segue.destinationViewController;
    secondVC.idTitle = [NSString stringWithFormat:@"%d",selectItem+1];
}


@end
