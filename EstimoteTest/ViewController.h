//
//  ViewController.h
//  EstimoteTest
//
//  Created by js on 11/3/14.
//  Copyright (c) 2014 js. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/ESTBeacon.h>
#import <EstimoteSDK/ESTBeaconManager.h>

@interface ViewController : UIViewController <ESTBeaconDelegate>
- (id)initWithBeacon:(ESTBeacon *)beacon;

@end

