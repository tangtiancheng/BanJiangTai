//
//  JSONModel+RACExtensions.h
//
//  Created by Dal Rupnik on 1/21/15
//  Copyright (c) 2015 arvystate.net. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JSONModel.h"

@interface JSONModel (RACExtensions)

/*!
 *  Parse signal for any object. If object is a dictionary and not a model,
 *  the signal will traverse the key-values for arrays or dictionaries of the model. This method will also traverse key-values in RACTuple
 *
 *  @param object dictionary or array or RACTuple
 *
 *  @return signal
 */
+ (RACSignal *)parseSignalForObject:(id)object;

/*!
 *  Return parse signal for model object, will parse if object is array or
 *  dictionary. If array is provided, it must contain dictionaries of models.
 *
 *  @param object model object either dictionary or array of model objects
 *
 *  @return signal
 */
+ (RACSignal *)parseSignalForModelObject:(id)object;

/*!
 *  Directly wraps JSONModel's initWithDictionary method
 *
 *  @param dictionary model dictionary
 *
 *  @return signal
 */
+ (RACSignal *)parseSignalForDictionary:(NSDictionary *)dictionary;

/*!
 *  Directly wraps JSONModel's arrayOfModelsFromDictionaries method
 *
 *  @param array array of models
 *
 *  @return signal
 */
+ (RACSignal *)parseSignalForArray:(NSArray *)array;

@end
