//
//  CCGenome.h
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCGenome : NSObject

@property (nonatomic, assign) NSInteger fitness;
@property (nonatomic, strong) NSArray *weights;

+ (instancetype)genomeWithWeights:(NSArray *)weights fitness:(NSInteger)fitness;

@end
