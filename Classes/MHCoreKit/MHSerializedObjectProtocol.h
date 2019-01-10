//
//  MHSerializedObjectProtocol.h
//  MHUIKIT
//
//  Created by minghe on 2019/1/10.
//

#import <Foundation/Foundation.h>





/*!
 @protocol
 @abstract      序列化Fundation对象抽象类
 */
@protocol MHFundationSerializedObjectProtocol <NSObject>

@optional
- (id) initWithDictionary:(NSDictionary*)dictionary;
- (id) initWithArray:(NSArray*)array;


@end


/*!
 @protocol
 @abstract      反序列化Fundation对象抽象类
 */
@protocol MHFundationDeserializedObjectProtocol <NSObject>

@optional
- (NSDictionary*) dictionaryValue;
- (NSArray*) arrayValue;
@end
