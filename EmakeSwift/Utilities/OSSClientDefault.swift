//
//  OSSClientDefault.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/8/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import AliyunOSSiOS
enum OSSUploadType {
    case image
    case voice
    case file
}
class OSSClientDefault {
    
    private static var _sharedInstance : OSSClientDefault?
    var tClient : OSSClient?
    
    class func getSharedInstance() -> OSSClientDefault{
        guard let instance = _sharedInstance else {
            _sharedInstance = OSSClientDefault()
            return _sharedInstance!
        }
        return instance
    }
    // 私有化init方法
    private init() {
        let provider = OSSCustomSignerCredentialProvider.init { (content, error) -> String? in
            let signature = OSSUtil.calBase64Sha1(withData: content, withSecret: ALiYunOSSSecretKey)
            if signature != nil{
                return "OSS " + ALiYunOSSAccessKey + ":" + signature!
            }else{
                return nil
            }
        }
        let conf = OSSClientConfiguration()
        conf.maxRetryCount = 2
        conf.timeoutIntervalForRequest = 30
        conf.timeoutIntervalForResource = 24 * 60 * 60
        tClient = OSSClient.init(endpoint: ALiYunOSSEndPoint, credentialProvider: provider!,clientConfiguration:conf)
    }
    
    //上传
    public func uploadObjectAsync(uploadData:Data,fileName:String,type:OSSUploadType,successBlock:@escaping ()->(),failureblock:@escaping ()->()){
        
        let request = OSSPutObjectRequest()
        switch type {
        case .image:
            request.bucketName = ALiYunOSSBucketNameImage
            request.objectKey = ALiYunOSSBucketNameImageObjectKey + fileName
        case .voice:
            request.bucketName = ALiYunOSSBucketNameVoice
            request.objectKey = ALiYunOSSBucketNameImageVoiceKey + fileName
        default:
            request.bucketName = ALiYunOSSBucketNameVoice
            request.objectKey = ALiYunOSSBucketNameImageFileKey + fileName
        }
        request.uploadingData = uploadData
        print("objectKey: \(request.objectKey)")
        let putTask = tClient?.putObject(request)
        putTask?.continue({ (task) -> Any? in
            if task.error == nil{
                print("上传成功");
                successBlock()
            }else{
                print("上传失败");
                failureblock()
            }
            return nil
        })
    }
    
    //下载
    public func downloadObjectAsync(fileName:String,downloadTargetFile:String, type:OSSUploadType,successBlock:@escaping ()->(),failureblock:@escaping ()->()){
        
        let request = OSSGetObjectRequest()
        switch type {
        case .image:
            request.bucketName = ALiYunOSSBucketNameImage
            request.objectKey = ALiYunOSSBucketNameImageObjectKey + fileName
        case .voice:
            request.bucketName = ALiYunOSSBucketNameVoice
            request.objectKey = ALiYunOSSBucketNameImageVoiceKey + fileName
        default:
            request.bucketName = ALiYunOSSBucketNameVoice
            request.objectKey = ALiYunOSSBucketNameImageFileKey + fileName
        }
        request.downloadToFileURL = NSURL.fileURL(withPath: downloadTargetFile)
        let downloadTask = tClient?.getObject(request)
        downloadTask?.continue({ (task) -> Any? in
            if task.error == nil{
                successBlock()
                print("下载成功");
            }else{
                failureblock()
                print("下载失败");
            }
            return nil
        })
    
    }
}
