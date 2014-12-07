/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "JpHsjTicustompasteboardModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation JpHsjTicustompasteboardModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"52ec55ce-d0b7-4cd3-84ff-05d3b96cb0ff";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.hsj.ticustompasteboard";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}


-(void)createPasteboard:(id)args
{
    // arg parse
    id arg = [args objectAtIndex:0];
	NSString *pasteboardName = [TiUtils stringValue:arg];
    
    // main
    UIPasteboard* pb = [UIPasteboard pasteboardWithName:pasteboardName create:YES];
    pb.persistent = YES;
}
-(void)removePasteboard:(id)args
{
    // arg parse
    id arg = [args objectAtIndex:0];
	NSString *pasteboardName = [TiUtils stringValue:arg];
    
    // main
    [UIPasteboard removePasteboardWithName:pasteboardName];
}

-(void)setString:(id)args
//(NSString *)pasteboardName text:(NSString *)text
{
    // arg parse
    id arg0 = [args objectAtIndex:0];
    id arg1 = [args objectAtIndex:1];
    NSString *pasteboardName = [TiUtils stringValue:arg0];
    NSString *text           = [TiUtils stringValue:arg1];
    
    // main
    UIPasteboard* pb = [UIPasteboard pasteboardWithName:pasteboardName create:YES];
    pb.persistent = YES;
    [pb setString:text];
}

-(NSString*)getString:(id)args
{
    // arg parse
    id arg = [args objectAtIndex:0];
	NSString *pasteboardName = [TiUtils stringValue:arg];
    
    // main
    UIPasteboard* pb = [UIPasteboard pasteboardWithName:pasteboardName create:NO];
    return pb.string;
}

-(void)setImage:(id)args
{
    // arg parse
    id arg = [args objectAtIndex:0];
    UIImage *image = [TiUtils image:[args objectAtIndex:1] proxy:self];
	NSString *pasteboardName = [TiUtils stringValue:arg];
    
    UIPasteboard* pb = [UIPasteboard pasteboardWithName:pasteboardName create:YES];
    pb.persistent = YES;
    [pb setImage: image];
}

-(id)getImage:(id)args
{
    // arg parse
    id arg0 = [args objectAtIndex:0];
    NSString *pasteboardName = [TiUtils stringValue:arg0];
    // main
    UIPasteboard* pb = [UIPasteboard pasteboardWithName:pasteboardName create:NO];
    return [[[TiBlob alloc] initWithImage:pb.image] autorelease];
}

-(NSString *)getGeneralPasteboardName:(id)args
{
    return [UIPasteboard generalPasteboard].name;
}

-(void)setGeneralString:(id)args
{
    // arg parse
    id arg = [args objectAtIndex:0];
    NSString *text = [TiUtils stringValue:arg];

    // main
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:text forPasteboardType:@"public.text"];
}

-(NSString *)getGeneralString:(id)args
{
    // main
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    return [pb valueForPasteboardType:@"public.text"];
}

-(void)setGeneralImage:(id)args
{
    // arg parse
    //UIImage *image = [TiUtils image:[args objectAtIndex:0] proxy:self];
    UIImage *image = [TiUtils image:args proxy:self];

    // main
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setData:UIImagePNGRepresentation(image) forPasteboardType:@"public.png"];
}

-(id)getGeneralImage:(id)args
{
    // main
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    UIImage *image = [UIImage imageWithData:[pb dataForPasteboardType:@"public.png"]];
    return [[[TiBlob alloc] initWithImage:image] autorelease];
}

@end
