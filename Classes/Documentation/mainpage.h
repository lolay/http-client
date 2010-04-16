/**
* @mainpage HttpClient
* 
* @author Scott Slaugh
* 
* @section intro Introduction
* HttpClient provides a basic implementation of several commands which are useful with doing HTTP programming.
* The commands supported are GET, POST, PUT and DELETE.
* Multipart POST commands are also supported for uploading files.
* The library is modeled after the Apache HttpClient library.
* <br>
* This library currently runs on a single thread.  However, I do plan to add an interface to use this library asynchronously.
* 
* @section usage Usage Examples
* @subsection get GET Command
* @code
#import "HttpClient.h"

GetMethod * get = [[GetMethod alloc] init];
[get addParameter:@"myFirstParam" withName:@"param1Name"];
[get addParameter:@"mySecondParam" withName:@"param2Name"];
NSURL * destURL = [NSURL URLWithString:@"http://some.url.com"];
HttpResponse * result = [get executeAtURL:destURL];
NSLog(@"Server response was %@", [result responseString]);
* @endcode
*
* @subsection post POST Command
* @code
#import "HttpClient.h"
 
PostMethod * post = [[PostMethod alloc] init];
[post addParameter:@"param1Data" withName:@"param1Name"];
[post addParameter:@"param2Data" withName:@"param2Name"];
NSURL * destURL = [NSURL URLWithString:@"http://some.url.com"];
HttpResponse * result = [post executeAtURL:destURL];
NSLog(@"Server response was %@", [result responseString]);
* @endcode
*
* Both the GET and POST methods also have a method that lets you add all of the items in a NSDictionary at once:
@code
[post addParametersFromDictionary:paramDict];
@endcode
*
* @subsection multipart Multipart POST Command
* @code 
#import "HttpClient.h"
 
MultipartMethod * multiPart = [[MultipartMethod alloc] init];
[multiPart addPart:[[StringPart alloc] initWithParameter:@"param1Data" withName:@"param1Name"]];
[multiPart addPart:[StringPart stringPartWithParameter:@"param2Data" withName:@"param2Name"]];
NSURL * fileURL = [NSURL fileURLWithPath:@"\path]\to\file.txt"];
[multiPart addPart:[FilePart filePartWithFile:fileURL withName:@"uploadFile" compressFile:YES]];
NSURL * destURL = [NSURL URLWithString:@"http://some.url.com"];
HttpResponse * result = [multiPart executeAtURL:destURL];
NSLog(@"Server response was %@", [result responseString]);
* @endcode
*
* The Multipart method also has a method to add all of the values in a NSDictionary as string parts:
@code
[multiPart addStringPartsFromDictionary:paramDict];
@endcode
*
* @subsection put PUT Command
* @code
#import "HttpClient.h"
 
NSURL * fileURL = [NSURL fileURLWithPath:@"\path]\to\file.txt"];
PutMethod * put = [[PutMethod alloc] initWithContentsOfURL:fileURL];
NSURL * destURL = [NSURL URLWithString:@"http://some.url.com"];
HttpResponse * response = [put executeAtURL:destURL];
NSLog(@"Server response code was %d", [result statusCode]);
* @endcode
*
* @subsection delete DELETE Command
* @code
#import "HttpClient.h"
 
DeleteMethod * delete = [[DeleteMethod alloc] init];
NSURL * deleteURL = [NSURL URLWithString:@"http://resource.to.delete"];
HttpResponse * response = [put executeAtURL:deleteURL];
NSLog(@"Server response code was %d", [result statusCode]);
* @endcode
*/