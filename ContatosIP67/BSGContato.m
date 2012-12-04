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
    }
    
    return self;
    
    
}

@synthesize nome = _nome;

@synthesize telefone = _telefone;

@synthesize email = _email;

@synthesize endereco = _endereco;

@synthesize site = _site;

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefone forKey:@"telefone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.endereco forKey:@"endereco"];
    [aCoder encodeObject:self.site forKey:@"site"];


    
}




@end
