#!/usr/bin/env python
#coding=utf-8
import os
import commands
import requests
import webbrowser

#参考：https://www.jianshu.com/p/1f47066da6f7
#使用注意事项:该脚本基于python2.7
# 1、将工程的编译设备选成 Gemeric iOS Device
# 2、command + B编译
# 3、执行脚本文件

#项目地址
#appFileFullPath = '/Users/liyunxin/Library/Developer/Xcode/DerivedData/globalDB-atzooopjkpinvbbtexbmwakhzbub/Build/Products/Debug-iphoneos/globalDB.app'
#appFileFullPath = '/Users/liyunxin/Library/Developer/Xcode/DerivedData/globalDB-atzooopjkpinvbbtexbmwakhzbub/Build/Products/Release-iphoneos/globalDB.app'
appFileFullPath = '/Users/liyunxin/Library/Developer/Xcode/DerivedData/KHealthDoctor-cqflfahpsnkjtcayigheiowjyzze/Build/Products/Debug-iphoneos/KHealthDoctor.app'

#appFileFullPath = '/Users/liyunxin/Library/Developer/Xcode/DerivedData/KHAtom-bqrmmkredwzuffckpepxoyvqydis/Build/Products/Debug-iphoneos/KHAtom.app'
PayLoadPath = '/Users/liyunxin/Desktop/Payload'
packBagPath = '/Users/liyunxin/Desktop/ProgramBag'

#蒲公英相关
API_KEY  = "5a08f47d2161467ff2d597cdc32858f2"
USER_KEY = "092b002e9700d9b4c8273ccd21aa35cf"

#log文案
Log_dabao_Will  = "德玛西亚 准备打包 - 我的剑就是你的剑"
Log_dabao_Begin = "德玛西亚 开始打包 - "
Log_dabao_Succ  = "德玛西亚 打包成功 - 我要觉醒了"
Log_upload_Fail = "德玛西亚 没有找到对应上传的IPA包 - 我死了"
Log_upload_Will = "德玛西亚 开始上传 - 控制自己，掌控敌人"
Log_upload_Succ = "德玛西亚 上传成功 - 通向不朽的关键，不死就行了！"

#上传蒲公英
def uploadIPA(IPAPath):
    if(IPAPath==''):
        print Log_upload_Fail
        return
    else:
        print Log_upload_Will
        url='http://www.pgyer.com/apiv1/app/upload'
        data={
            'uKey':USER_KEY,
            '_api_key':API_KEY,
            'installType':'2',
            'password':'',
            'updateDescription':''
        }
        files={'file':open(IPAPath,'rb')}
        r=requests.post(url,data=data,files=files)
    print Log_upload_Succ

#创建PayLoad文件夹
def mkdir(PayLoadPath):
    isExists = os.path.exists(PayLoadPath)
    if not isExists:
        os.makedirs(PayLoadPath)
        print Log_dabao_Begin + PayLoadPath + ' 创建成功'
        return True
    else:
        print Log_dabao_Begin + PayLoadPath + ' 目录已经存在'
        return False


#编译打包流程
def bulidIPA():
    print Log_dabao_Will
    #打包之前先删除packBagPath下的文件夹
    commands.getoutput('rm -rf %s'%packBagPath)
    #创建PayLoad文件夹
    mkdir(PayLoadPath)
    #将app拷贝到PayLoadPath路径下
    commands.getoutput('cp -r %s %s'%(appFileFullPath,PayLoadPath))
    #在桌面上创建packBagPath的文件夹
    commands.getoutput('mkdir -p %s'%packBagPath)
    #将PayLoadPath文件夹拷贝到packBagPath文件夹下
    commands.getoutput('cp -r %s %s'%(PayLoadPath,packBagPath))
    #删除桌面的PayLoadPath文件夹
    commands.getoutput('rm -rf %s'%(PayLoadPath))
    #切换到当前目录
    os.chdir(packBagPath)
    #压缩packBagPath文件夹下的PayLoadPath文件夹
    commands.getoutput('zip -r ./Payload.zip .')
    print Log_dabao_Succ
    #将zip文件改名为ipa
    commands.getoutput('mv Payload.zip Payload.ipa')
    #删除payLoad文件夹
    commands.getoutput('rm -rf ./Payload')

if __name__ == '__main__':
    #打包
    bulidIPA()
    #上传到蒲公英
    uploadIPA('%s/Payload.ipa'%packBagPath)

