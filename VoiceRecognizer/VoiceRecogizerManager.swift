//
//  VoiceRecogizerManager.swift
//  ExAuto
//
//  Created by mapbarDaLian on 16/5/12.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation



public class VoiceRecogizerManager:NSObject,IFlySpeechRecognizerDelegate {

    var iflySpeechRecognizer:IFlySpeechRecognizer = IFlySpeechRecognizer.sharedInstance() as! IFlySpeechRecognizer;
    public func voiceRecogizerInitWithAppId(appId : String){
    
        var initString:String
        initString="appid="+appId+",timeout="+TIMEOUT_VALUE;
        
        //所有服务启动前，需要确保执行createUtility
        IFlySpeechUtility.createUtility(initString);
        
        self.iflySpeechRecognizer.delegate = self;//请不要删除这句,createRecognizer是单例方法，需要重新设置代理
        self.iflySpeechRecognizer.setParameter("asr", forKey: IFlySpeechConstant.IFLY_DOMAIN())
        self.iflySpeechRecognizer.setParameter("16000", forKey: IFlySpeechConstant.SAMPLE_RATE())
        self.iflySpeechRecognizer.setParameter("asr.pcm", forKey: IFlySpeechConstant.ASR_AUDIO_PATH())
        // | result_type   | 返回结果的数据格式 plain,只支持plain
        self.iflySpeechRecognizer.setParameter("plain", forKey: IFlySpeechConstant.RESULT_TYPE())
    
    }
    
    /**
     * @fn      startListening
     * @brief   开始监听
     *
     * @see
     */
    
    @objc public func startListening(){
    
      self.iflySpeechRecognizer.startListening()
    
    }
    /**
     * @fn      stopListening
     * @brief   停止监听
     *
     * @see
     */
    @objc public func stopListening(){
        
       self.iflySpeechRecognizer.stopListening()
    
    }
    
    
    @objc public func onVolumeChanged(volume: Int32) {
        NSLog("音量：\(volume)")
    }
    
    /**
     * @fn      onBeginOfSpeech
     * @brief   开始识别回调
     *
     * @see
     */
    @objc public func onBeginOfSpeech(){
        NSLog("onEndOfSpeech")
    }
    
    /**
     * @fn      onEndOfSpeech
     * @brief   停止录音回调
     *
     * @see
     */
    @objc public func onEndOfSpeech(){
        NSLog("onEndOfSpeech")
    }
    
    /**
     * @fn      onError
     * @brief   识别结束回调
     *
     * @param   errorCode   -[out] 错误类，具体用法见IFlySpeechError
     */
    @objc public func onError(error:IFlySpeechError){
        NSLog("onError:\(error.errorDesc)")
    }
    
    /**
     * @fn      onResults
     * @brief   识别结果回调
     *
     * @param   result      -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度
     * @see
     */
    
    @objc public func onResults( results:Array<AnyObject>, isLast:Bool){
        
        var result:String="";
        if(results.count>0){
            let dic:NSDictionary = results[0] as! NSDictionary;
            for (key,value) in dic {
                result="\(key) (置信度:\(value))\n";
            }
            NSLog(result)
            // self.resultTextView.text=self.resultTextView!.text+result
        }
        
    }
    /**
     * @fn      onCancal
     * @brief   取消识别回调
     *
     * @see
     */
    
    @objc public func onCancel(){
        NSLog("onCancel")
    }






}