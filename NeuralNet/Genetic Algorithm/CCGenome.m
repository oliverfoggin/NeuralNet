//
//  CCGenome.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCGenome.h"

@implementation CCGenome

+ (instancetype)genomeWithWeights:(NSArray *)weights fitness:(NSInteger)fitness
{
    return [[self alloc] initWithWeights:weights fitness:fitness];
}

- (instancetype)initWithWeights:(NSArray *)weights fitness:(NSInteger)fitness
{
    self = [super init];
    if (self) {
        self.weights = weights;
        self.fitness = fitness;
    }
    return self;
}

- (NSComparisonResult)compare:(CCGenome *)otherGenome
{
    return self.fitness == otherGenome.fitness ? NSOrderedSame : self.fitness > otherGenome.fitness ? NSOrderedDescending : NSOrderedAscending;
}

@end
