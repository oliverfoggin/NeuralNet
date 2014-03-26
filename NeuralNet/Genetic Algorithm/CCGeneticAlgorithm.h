//
//  CCGeneticAlgorithm.h
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCGeneticAlgorithm : NSObject

- (NSArray *)epoch:(NSArray *)oldPopulation;

@end
