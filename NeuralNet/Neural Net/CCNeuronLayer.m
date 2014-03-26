//
//  CCNeuronLayer.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCNeuronLayer.h"

#import "CCNeuron.h"

@implementation CCNeuronLayer

+ (instancetype)neuronLayerWithNumNeurons:(NSInteger)numberOfNeurons numberOfInputsPerNeuron:(NSInteger)numberOfInputs
{
    return [[self alloc] initWithNumNeurons:numberOfNeurons numberOfInputsPerNeuron:numberOfInputs];
}

- (id)initWithNumNeurons:(NSInteger)numberOfNeurons numberOfInputsPerNeuron:(NSInteger)numberOfInputs
{
    self = [super init];
    if (self) {
        NSMutableArray *mutableNeurons = [NSMutableArray arrayWithCapacity:numberOfNeurons];
        
        for (int i=0; i<numberOfNeurons; ++i) {
            [mutableNeurons addObject:[CCNeuron neuronWithNumberOfInputs:numberOfInputs]];
        }
        
        self.neurons = mutableNeurons;
    }
    return self;
}

- (NSArray *)calculateOutputsFromInputs:(NSArray *)inputs
{
    //inputs is NSArray of NSNumber either 1 or 0
    NSMutableArray *outputs = [NSMutableArray arrayWithCapacity:self.neurons.count];
    
    for (CCNeuron *neuron in self.neurons) {
        [outputs addObject:[neuron calculateOutputFromInputs:inputs]];
    }
    
    //outputs is a new NSArray of NSNumber either 1 or 0
    return outputs;
}

@end
