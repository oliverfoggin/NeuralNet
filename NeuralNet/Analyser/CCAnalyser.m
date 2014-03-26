//
//  CCAnalyser.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCAnalyser.h"
#import "CCNeuralNet.h"

@implementation CCAnalyser

- (id)init
{
    self = [super init];
    if (self) {
        self.brain = [CCNeuralNet neuralNetWithNumInputs:8
                                              numOutputs:1
                                         numHiddenLayers:1
                                numNeuronsPerHiddenLayer:6];
        _fitness = 0;
    }
    return self;
}

- (void)reset
{
    _fitness = 0;
}

- (void)incrementFitness
{
    ++_fitness;
}

- (NSArray *)analysePixelInput:(NSArray *)pixels
{
    return [self.brain update:pixels];
}

@end
