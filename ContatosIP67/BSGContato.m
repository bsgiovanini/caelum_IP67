//
//  BSGContato.m
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGContato.h"

@implementation BSGContato

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
    self.nome = [aDecoder decodeObjectForKey:@"nome"] ;
    self.telefone = [aDecoder decodeObjectForKey:@"telefone"] ;
    self.email = [aDecoder decodeObjectForKey:@"email"] ;
    self.endereco = [aDecoder decodeObjectForKey:@"endereco"] ;
    self.site = [aDecoder decodeObjectForKey:@"site"] ;
    self.photo = [aDecoder decodeObjectForKey:@"photo"];   
    self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
    self.longitude = [aDecoder decodeObjectForKey:@"longitude"];    
    }
    
    return self;
    
    
}

@dynamic nome;

@dynamic telefone ;

@dynamic email ;

@dynamic endereco ;

@dynamic site ;

@synthesize photo = _photo ;

@dynamic latitude ;

@dynamic longitude ;


- (CLLocationCoordinate2D) coordinate {
    NSLog(@"%@", self.latitude);
    NSLog(@"%@", self.longitude);
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString*) title {
    return self.nome;
}

- (NSString*) subtitle {
    return self.email;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefone forKey:@"telefone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.endereco forKey:@"endereco"];
    [aCoder encodeObject:self.site forKey:@"site"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    
}




@end
