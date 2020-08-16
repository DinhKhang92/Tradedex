import os
import glob
import Image


def resize_screenshots():
    os.chdir(screenshots_path)
    for file in glob.glob("*.jpg"):
        img = Image.open(screenshots_path+file)
        img = img.resize((240, 400), Image.ANTIALIAS)

        img.save(screenshots_path+"_ads_"+file)


if __name__ == "__main__":
    screenshots_path = 'B:\\Flutter_Project\\tradedex\\Android_Screenshots\\'
    resize_screenshots()
