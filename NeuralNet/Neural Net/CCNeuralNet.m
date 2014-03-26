//
//  CCNeuralNet.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCNeuralNet.h"
#import "CCNeuronLayer.h"
#import "CCNeuron.h"

@interface CCNeuralNet ()

@property (nonatomic, assign) NSInteger numberOfInputs;
@property (nonatomic, assign) NSInteger numberOfHiddenLayers;

@end

@implementation CCNeuralNet

+ (instancetype)neuralNetWithNumInputs:(NSInteger)numInputs
                            numOutputs:(NSInteger)numOutputs
                       numHiddenLayers:(NSInteger)numHiddenLayers
              numNeuronsPerHiddenLayer:(NSInteger)numNeuronsPerHiddenLayer
{
    return [[self alloc] initWithNumInputs:numInputs numOutputs:numOutputs numHiddenLayers:numHiddenLayers numNeuronsPerHiddenLayer:numNeuronsPerHiddenLayer];
}

- (id)initWithNumInputs:(NSInteger)numInputs
             numOutputs:(NSInteger)numOutputs
        numHiddenLayers:(NSInteger)numHiddenLayers
numNeuronsPerHiddenLayer:(NSInteger)numNeuronsPerHiddenLayer
{
    self = [super init];
    if (self) {
        self.numberOfInputs = numInputs;
        self.numberOfHiddenLayers = numHiddenLayers;
        
        NSMutableArray *mutableLayers = [NSMutableArray array];
        
        if (numHiddenLayers > 0) {
            [mutableLayers addObject:[CCNeuronLayer neuronLayerWithNumNeurons:numNeuronsPerHiddenLayer numberOfInputsPerNeuron:numInputs]];
            
            for (int i=0; i<numHiddenLayers-1; ++i) {
                [mutableLayers addObject:[CCNeuronLayer neuronLayerWithNumNeurons:numNeuronsPerHiddenLayer numberOfInputsPerNeuron:numNeuronsPerHiddenLayer]];
            }
            
            [mutableLayers addObject:[CCNeuronLayer neuronLayerWithNumNeurons:numOutputs numberOfInputsPerNeuron:numNeuronsPerHiddenLayer]];
        } else {
            [mutableLayers addObject:[CCNeuronLayer neuronLayerWithNumNeurons:numOutputs numberOfInputsPerNeuron:numInputs]];
        }
        self.layers = mutableLayers;
    }
    return self;
}

- (NSArray *)update:(NSArray *)inputs
{
    // inputs = array of @(1) or @(0)
    
    // outputs = array of @(1) or @(0)
    // it will only have one output for now
    NSArray *outputs;
    
    if (inputs.count != self.numberOfInputs) {
        return outputs;
    }
    
    for (int i=0; i<self.numberOfHiddenLayers + 1; ++i) {
        if (i > 0) {
            inputs = [NSArray arrayWithArray:outputs];
        }
        
        CCNeuronLayer *layer = self.layers[i];
        
        outputs = [layer calculateOutputsFromInputs:inputs];
    }
    
    return outputs;
}

- (void)setWeights:(NSArray *)weights
{
    if (weights.count != [self weights].count) {
        return;
    }
    
    NSInteger weightIndex = 0;
    
    for (CCNeuronLayer *layer in self.layers) {
        for (CCNeuron *neuron in layer.neurons) {
            NSMutableArray *mutableWeights = [NSMutableArray array];
            
            for (int i=0; i<neuron.weights.count; ++i) {
                [mutableWeights addObject:weights[weightIndex++]];
            }
            
            neuron.weights = mutableWeights;
        }
    }
}

- (NSArray *)weights
{
    NSMutableArray *mutableWeights = [NSMutableArray array];
    
    for (CCNeuronLayer *layer in self.layers) {
        for (CCNeuron *neuron in layer.neurons) {
            [mutableWeights addObjectsFromArray:neuron.weights];
        }
    }
    
    return mutableWeights;
}

- (void)printGenome
{
    NSMutableString *string = [NSMutableString stringWithString:@"@["];
    
    for (CCNeuronLayer *layer in self.layers) {
        for (CCNeuron *neuron in layer.neurons) {
            for (NSNumber *weight in neuron.weights) {
                [string appendFormat:@"@(%@),", weight];
            }
        }
    }
    
    string = [[string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] mutableCopy];
    
    [string appendString:@"];"];
    
    NSLog(@"Genome: %@", string);
}

@end
