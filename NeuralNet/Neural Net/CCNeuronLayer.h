//
//  CCNeuronLayer.h
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCNeuronLayer : NSObject

@property (nonatomic, strong) NSArray *neurons;

+ (instancetype)neuronLayerWithNumNeurons:(NSInteger)numberOfNeurons
                  numberOfInputsPerNeuron:(NSInteger)numberOfInputs;

- (NSArray *)calculateOutputsFromInputs:(NSArray *)inputs;

@end
