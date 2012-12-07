//
//  BSGContato.h
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface BSGContato : NSManagedObject <NSCoding, MKAnnotation>

@property (strong) NSString * nome;

@property (strong) NSString * telefone;

@property (strong) NSString * email;

@property (strong) NSString * endereco;

@property (strong) NSString * site;

@property (strong) UIImage * photo;

@property (strong) NSNumber * latitude;

@property (strong) NSNumber * longitude;

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly, copy) NSString *subtitle;

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
