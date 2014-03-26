//
//  CCNeuralNet.h
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCNeuralNet : NSObject

@property (nonatomic, strong) NSArray *layers;

+ (instancetype)neuralNetWithNumInputs:(NSInteger)numInputs
                            numOutputs:(NSInteger)numOutputs
                       numHiddenLayers:(NSInteger)numHiddenLayers
              numNeuronsPerHiddenLayer:(NSInteger)numNeuronsPerHiddenLayer;

- (NSArray *)update:(NSArray *)inputs;

- (void)setWeights:(NSArray *)weights;
- (NSArray *)weights;
- (void)printGenome;

@end
