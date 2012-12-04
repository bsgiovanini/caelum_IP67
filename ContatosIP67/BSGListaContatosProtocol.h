//
//  BSGListaContatosProtocol.h
//  ContatosIP67
//
//  Created by ios3109 on 04/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSGContato.h"

@protocol BSGListaContatosProtocol <NSObject>

- (void) contatoAtualizado: (BSGContato *) contato;

- (void) contatoAdicionado: (BSGContato *) contato;

@end
