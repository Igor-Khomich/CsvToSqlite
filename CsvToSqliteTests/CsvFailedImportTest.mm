#import "CsvFailedImportTest.h"

#import "MockDb.h"

#import "CsvToSqlite+Test.h"

#import "UnixLineReader.h"
#import "WindowsLineReader.h"

@implementation CsvFailedImportTest

-(void)testUnexpectedDbHeaders
{
    NSError*  error_    = nil;
    
    NSString* csvPath_ = [ [ NSBundle bundleForClass: [ self class ] ] pathForResource: @"UnixTest" 
                                                                                ofType: @"csv" ];
    
    NSDictionary* schema_ = [ NSDictionary dictionaryWithObject: @"amba" 
                                                         forKey: @"karamba" ];

    CsvToSqlite* converter_ = [ [ CsvToSqlite alloc ] initWithDatabaseName: @"5.sqlite" 
                                                              dataFileName: csvPath_ 
                                                            databaseSchema: schema_ 
                                                                primaryKey: nil
                                                             separatorChar: ';'
                                                                lineReader: [ UnixLineReader new ] 
                                                            dbWrapperClass: [ MockDb class ] ];
    
    MockDb* dbWrapper_ = ( MockDb* )converter_.dbWrapper ;
    STAssertNotNil( dbWrapper_, @"DB initialization error ");
    
    
    BOOL result_ = [ converter_  storeDataInTable: @"Campaigns" 
                                            error: &error_ ];   
    STAssertFalse( result_, @"Unexpected success" );
    
//    STAssertNotNil( error_, @"Unexpected error" );
//    
//    STAssertTrue( [ error_.domain isEqualToString: @"org.EmbeddedSources.CSV.import" ], @"error domain mismatch" );
//    STAssertTrue( error_.code == 2, @"error code mismatch" );
//    
//    STAssertTrue( [ [ dbWrapper_ queriesLog ] count ] == 0, @"Unexpected query occured" );
}

@end
