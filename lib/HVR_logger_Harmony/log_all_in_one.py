# -*- coding: UTF-8 -*-
import gzip 
import os
import os.path as osp
import argparse
import pprint
import sys


def get_applog_gz_list(root):
    print (root)
    applog_gz_list = []
    for path, _, files in os.walk(root):
        for file in files:
            if file.startswith("hiapplogcat") and file.endswith(".gz"):
                applog_gz_list.append(osp.join(path,file))

    return applog_gz_list


def all_in_one(applog_gz_list, dst_log_path):
    with open(dst_log_path, 'wb') as f_dst:
        for src_log_path in applog_gz_list:
            g_file = gzip.GzipFile(src_log_path)
            f_dst.write(g_file.read())



if __name__ == "__main__":
    import datetime
    parser = argparse.ArgumentParser(description=u'''
    合并多个log文件为一个文件，其中这多个log的文件名以“applogcat”开头、“.gz”结尾
    ''')
    time_string=datetime.datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    parser.add_argument('--src', help=u'原始log路径', default='./')
    parser.add_argument('--dst', help=u'输出log路径', default='out/'+time_string+'.txt')
    args = parser.parse_args()

    applog_gz_list = get_applog_gz_list(args.src)
    if 0 == len(applog_gz_list):
        print ("\tThere is no filename startswith 'applogcat' and endswith '.gz', \n\tpls check the log is whether complete!")
        sys.exit()

    
    all_in_one(applog_gz_list, os.path.abspath(args.dst))

    print ("Logs: \n\t%s \n have been merged into:\n\t %s" % ('\n\t'.join(applog_gz_list), os.path.abspath(args.dst)))
