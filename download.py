#!/usr/bin/python

""" DOWNLOAD PICTURES FROM TEXT FILE """
import sys
import os.path
import urllib

FOLDER_NAME = "pictures/" #CONSTANT FOLDER NAME

#PARAM url_array
def download(url_array): # TODO: unittest
    """ DOWNLOADS PICTURES INSIDE OF DEFINED FOLDER """
    count = 0
    for picture_url in url_array:
        if not picture_url == "":
            ret = urllib.urlopen(picture_url) #CHECK IF URL IS EXISTS

            if ret.code == 200:
                _ , filename = picture_url.rsplit("/", 1) #GET FILE NAME
                # filename = picture_url[picture_url.rfind("/")+1:]
                print "Downloading..." + picture_url + " in " + FOLDER_NAME
                urllib.urlretrieve(picture_url, FOLDER_NAME + filename) #DOWNLOAD PICTURE INSIDE OF FOLDER
                count += 1 #INCREASE THE DOWNLOADED PICTURE COUNT
            else:
                print("Please enter a file name")
    #RETURN DOWNLOADED PICTURE COUNT
    return count

if __name__=="__main__": #CHECK IF FILE DIRECTLY EXECUTED
    if not len(sys.argv)>1: #CHECK IF ARGUMENT EXISTS
	print("Please enter file name")
	sys.exit(1)

    txtName = sys.argv[1].strip()
    if txtName=="": #CHECK FILE NAME EMPTY
        print("Please enter a file name")
        sys.exit(1)

    if not os.path.isfile(txtName): #CHECK FILE EXISTS
        print("File Doesn't exists")
        sys.exit(1)

    if not os.path.isdir(FOLDER_NAME): #CHECK DOWNLOAD FOLDER EXISTS
        try:
            os.makedirs(FOLDER_NAME)
            print("Pictures folder created")
        except:
            print("Folder can not create")
            sys.exit(1)
    try:
        with open(txtName, 'r') as f:
            text = f.read().strip() #TRIM THE TEXT
            url_lines = text.split("\n") #SPLIT LINE BY LINE
    except:
        print("File can not open")
        sys.exit(1)

    if len(url_lines)>0: #IF ARRAY LENGTH MORE THAN 0
        count = download(url_lines)
        print str(count) + " Pictures downloaded"
