//
//  CCAnalyser.h
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCNeuralNet;

@interface CCAnalyser : NSObject

@property (nonatomic, strong) CCNeuralNet *brain;
@property (nonatomic, assign, readonly) NSInteger fitness;

- (void)reset;
- (void)incrementFitness;

- (NSArray *)analysePixelInput:(NSArray *)pixels;

@end
