//
//  FileManagerTool.m
//  Network
//
//  Created by lizq on 16/6/20.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQFileManagerTool.h"

@implementation LQFileManagerTool

+ (NSString*)getDocumentDirectoryPathString {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}

+ (NSString*)getCachesDirectoryPathString {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

+ (NSString*)getTemporaryDirectoryPathString {
     NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

+ (NSString*)getFilePathWithName:(NSString*)fileName ofType:(NSString*)fileType {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    return filePath;
}

+ (BOOL)createFileDirectory:(NSString*)directoryName {
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@",[self getDocumentDirectoryPathString],directoryName];
    NSLog(@"%@",directoryPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager isExecutableFileAtPath:directoryPath]) {
        BOOL isSuccess = [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        return isSuccess;
    }
    return YES;
}

+ (void)removeAllFileInDocumentDirection:(NSString*)directoryName {
    NSString *directName = directoryName;
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@",[self getDocumentDirectoryPathString],directName];
    [self removeAllFileInDirection:directoryPath];
}

+ (void)removeAllFileInDirection:(NSString*)directoryPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:directoryPath error:&error];
    if (fileList.count == 0) {
        return;
    }
    for (int i = 0 ; i < fileList.count; i++) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",directoryPath,fileList[i]];
        NSLog(@"%@",filePath);
        BOOL isRemove = [fileManager removeItemAtPath:filePath error:nil];
        if (isRemove) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }
}

+ (float)getTotalSizeInDocumentDirection:(NSString*)directoryName {
    NSString *directName = directoryName;
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@",[self getDocumentDirectoryPathString],directName];
    return [self getTotalSizeInDirection:directoryPath];
}

+ (float)getTotalSizeInDirection:(NSString *)directoryPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    float size = 0;
    NSArray *fileList = [fileManager subpathsOfDirectoryAtPath:directoryPath error:&error];
    if (fileList.count == 0) {
        return size;
    }
    for (NSString *fileName in fileList) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",directoryPath,fileName];
        NSDictionary *dic = [fileManager attributesOfItemAtPath:filePath error:nil];
        size += [dic[@"NSFileSize"] floatValue];
    }
    return size/1024;
}

+ (NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)directoryPath {
    
    NSMutableArray *fileNameList = [NSMutableArray arrayWithCapacity:0];
    NSArray *tmpList = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *fileName in tmpList) {
        NSString *fullPath = [directoryPath stringByAppendingPathComponent:fileName];
        if ([self isFileExistAtPath:fullPath]) {
            if ([[fileName pathExtension] isEqualToString:type]) {
                [fileNameList  addObject:fileName];
            }
        }
    }
    return fileNameList;
}

+ (BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}

@end
