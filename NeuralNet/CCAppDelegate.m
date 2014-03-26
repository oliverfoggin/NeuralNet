//
//  CCAppDelegate.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCAppDelegate.h"

#import "CCAnalyser.h"
#import "CCAnalyserFarm.h"
#import "CCNeuralNet.h"

@implementation CCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
//    CCAnalyserFarm *farm = [[CCAnalyserFarm alloc] init];
//
//    for (int i=0; i<4000; ++i) {
//        [farm updateAnalysers];
//    }
//
//    CCAnalyser *bestAnalyser = [farm bestAnalyser];
////    [bestAnalyser.brain printGenome];
//    
//    NSArray *weights = [bestAnalyser.brain weights];
//    
//    //String Path of file
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/brain.plist"];
//    
//    //Save
//    [weights writeToFile:path atomically:YES];
//    
//    NSLog(@"Done!");
}

@end
