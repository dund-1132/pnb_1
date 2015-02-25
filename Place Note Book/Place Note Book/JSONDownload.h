//
//  JSONDownload.h
//  Place Note Book
//
//  Created by framgiavn on 2/11/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONDownload : NSObject

+ (JSONDownload *)shareJSONDownload;

- (void)sendRequestWithURL:(NSString *)urlString;

- (void)sendRequestWithURL:(NSString *)urlString methodRequest:(NSString *)method;

- (void)sendRequestWithURL:(NSString *)urlString methodRequest:(NSString *)method bodyString:(NSString *)body;

/*
 * Chú ý khi kết nối hai máy tính
 * Bước 1 lấy địa chỉ IP của máy tính cần kết nối
 * Bước 2 ping tới địa chỉ máy tính cần kết nối để đảm bảo có thể truy cập, chú ý nếu không thể ping tới máy tính đó thì cần kiểm tra máy tính đó xem đã tắt tường lửa chưa, chưa tắt cần phải tắt, ngoài ra cần đảm bảo hai mục private network và guest or public networks cũng cần phải tắt
 * Bước 3 vào trình duyệt nhập địa chỉ ip để kiểm tra có thể truy cập không
 */

@end
