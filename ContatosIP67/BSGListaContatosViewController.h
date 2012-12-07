//
//  BSGListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios3109 on 29/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "BSGListaContatosProtocol.h"
#import "BSGContato.h"

@interface BSGListaContatosViewController : UITableViewController <BSGListaContatosProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (weak) NSMutableArray* contatos;

@property NSInteger linhaDestaque;

@property (weak) BSGContato* contatoSelecionado;

@property (weak) NSManagedObjectContext *contexto;



@end
