//
//  CCNeuron.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCNeuron.h"

@implementation CCNeuron

+ (instancetype)neuronWithNumberOfInputs:(NSInteger)numberOfInputs
{
    return [[self alloc] initWithNumberOfInputs:numberOfInputs];
}

- (id)initWithNumberOfInputs:(NSInteger)numberOfInputs
{
    self = [super init];
    if (self) {
        
        CGFloat minRange = -1;
        CGFloat maxRange = 1;
        
        NSMutableArray *mutableWeights = [NSMutableArray arrayWithCapacity:numberOfInputs];
        for (int i=0; i<numberOfInputs+1; ++i) {
            [mutableWeights addObject:@(((CGFloat)arc4random() / 0x100000000 * (maxRange - minRange)) + minRange)];
        }
        self.weights = mutableWeights;
    }
    return self;
}

- (NSNumber *)calculateOutputFromInputs:(NSArray *)inputs
{
    //inputs is NSArray of NSNumber either 1 or 0
    
    __block CGFloat result = 0;
    
    [self.weights enumerateObjectsUsingBlock:^(NSNumber *weight, NSUInteger idx, BOOL *stop) {
        if (idx == inputs.count) {
            *stop = YES;
            return;
        }
        
        result += [weight floatValue] * [inputs[idx] floatValue];
    }];
    
    result -= [[self.weights lastObject] floatValue];
    
    return result >= 0 ? @1 : @0;
}

@end
