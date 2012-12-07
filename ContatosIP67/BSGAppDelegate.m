//
//  BSGAppDelegate.m
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGAppDelegate.h"
#import "BSGFormularioContatoViewController.h"
#import "BSGListaContatosViewController.h"
#import "BSGContatosNoMapaViewController.h"

@implementation BSGAppDelegate

@synthesize window = _window;

@synthesize contatos = _contatos;

@synthesize arquivoContato = _arquivoContato;

@synthesize contexto = _contexto;

- (id)init {
    
    self = [super init];
    
    NSArray * ud = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * dd = [ud objectAtIndex: 0];
    
    self.arquivoContato = [NSString stringWithFormat:@"%@/Contatos",dd];
    
    return self;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    /*NSLog(@"%@", self.arquivoContato);
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile: self.arquivoContato];
    if (!self.contatos) {
         self.contatos = [[NSMutableArray alloc] init];
    }*/
    
    
    [self inserirDados];
    [self buscarContatos];
    
    BSGListaContatosViewController * lista = [[BSGListaContatosViewController alloc] init];
    
    lista.contexto = self.contexto;
    
    lista.contatos = self.contatos;
    
    BSGContatosNoMapaViewController *contatosMapa = [[BSGContatosNoMapaViewController alloc] init];
    
    contatosMapa.contatos = self.contatos;
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    UINavigationController * nav = [[UINavigationController alloc ] initWithRootViewController:lista];
    
    UINavigationController * navmapa = [[UINavigationController alloc ] initWithRootViewController:contatosMapa];
    
    
    
    tabController.viewControllers = [NSArray arrayWithObjects: nav, navmapa, nil] ;
    
   
    
    //BSGFormularioContatoViewController * form = [[BSGFormularioContatoViewController alloc] init];
    
    [self.window setRootViewController:tabController];
    
    NSLog(@"lauchOptions %@", launchOptions);
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    [self salvaContexto];    
    //[NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContato];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSURL*) applicationDocumentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask ] lastObject] ;
}

- (NSManagedObjectModel*) managedObjectModel {
    
    NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"Modelo_Contatos" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc ] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
    
}

-(NSPersistentStoreCoordinator *) coordinator {
    NSPersistentStoreCoordinator * coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *pastaDocuments = [self applicationDocumentDirectory];
    NSURL *localBancoDeDados = [pastaDocuments URLByAppendingPathComponent:@"Contatos.sqllite"];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBancoDeDados options:nil error:nil];
    
    return coordinator;
    
    
}


- (NSManagedObjectContext*) contexto {
    if (_contexto != nil) {
        return _contexto;
    }

    NSPersistentStoreCoordinator * coordinator = [self coordinator];
    _contexto = [[NSManagedObjectContext alloc] init];
    [_contexto setPersistentStoreCoordinator: coordinator];
    return _contexto;

}

- (void)salvaContexto {
    NSError *error;
    
    if (![self.contexto save:&error ]) {
        NSDictionary *infos = [error userInfo];
        NSArray *multiplosErros = [infos objectForKey:NSDetailedErrorsKey];
        if (multiplosErros) {
            for (NSError *erro in multiplosErros) {
                NSLog(@"Ocorreu problema: %@", [erro userInfo]);
            }
        } else {
            NSLog(@"Ocorreu problema: %@", infos);
        }
    }
}

- (void)inserirDados {
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [configs boolForKey:@"dados_inseridos"];
    if (!dadosInseridos) {
        BSGContato *caelumSp = [NSEntityDescription  insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.contexto];
        caelumSp.nome = @"Caelum SP";
        caelumSp.email = @"contato@caelum.com.br";
        caelumSp.endereco = @"rua tal";
        caelumSp.telefone = @"tel tal";
        caelumSp.site =@"site tal";
        caelumSp.latitude = [NSNumber numberWithDouble: -23.5];
        caelumSp.longitude = [NSNumber numberWithDouble: -46.5];
        
        [self salvaContexto];
        [configs setBool:YES forKey:@"dados_inseridos"];
        [configs synchronize];
    }
}

- (void)buscarContatos {
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordenaPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    [buscaContatos setSortDescriptors:[NSArray arrayWithObject:ordenaPorNome]];
    
    NSArray *contatosImutaveis = [self.contexto executeFetchRequest:buscaContatos error:nil];
    
    self.contatos = [contatosImutaveis mutableCopy];
    
    
    
    
    
}



@end
