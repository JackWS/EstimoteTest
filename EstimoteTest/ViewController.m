//
//  ViewController.m
//  EstimoteTest
//
//  Created by js on 11/3/14.
//  Copyright (c) 2014 js. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/ESTBeacon.h>
#import <EstimoteSDK/ESTBeaconManager.h>

@interface ViewController ()  <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeacon         *beacon;
@property (nonatomic, strong) ESTBeaconManager  *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;
@property (nonatomic, strong) NSUUID *proximityRegion;
//@property (nonatomic, strong) NSUUID *nuuid;
@end


@implementation ViewController

- (id)initWithBeacon:(ESTBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    /*
     * BeaconManager setup.
     */
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    if ([_beaconManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_beaconManager requestAlwaysAuthorization];
    }
    
    self.beaconRegion = [[ESTBeaconRegion alloc] init];
    
    //self.beacon.proximityUUID

    NSUUID *nuuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:nuuid major:[self.beacon.major unsignedIntValue] minor:[self.beacon.minor unsignedIntValue] identifier:@"RegionIdentifier"];
    self.beaconRegion.notifyOnEntry = TRUE;
    self.beaconRegion.notifyOnExit = TRUE;
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Enter region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    NSLog(@"Enter");

}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exit region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    NSLog(@"Exit");
}

@end
