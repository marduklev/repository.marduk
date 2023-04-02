# pip install Pillow
from PIL import ImageFilter, Image
'''
    https://pillow.readthedocs.io/en/stable/reference/ImageFilter.html#module-PIL.ImageFilter
    - class PIL.ImageFilter.UnsharpMask(radius=2, percent=150, threshold=3)
    - 
'''

import webbrowser
import os
from os.path import exists


# import hashlib
import time

# get the start time
st = time.time()

SOURCE_FP = r'C:\_data\blur_script\source'
SOURCE_FN = "Life In Space (2021)-fanart"
SOURCE_IMAGE = fr'{SOURCE_FP}\{SOURCE_FN}.jpg'
SOURCE_FNP = SOURCE_FP + SOURCE_FN + SOURCE_IMAGE


# def md5hash(value):
#    value = str(value).encode()
#    return hashlib.md5(value).hexdigest()


if __name__ == '__main__':

    # hd values
    # radius = int(20)
    # radius_spotlight = int(50)

    # shrinked values
    radius = int(4)
    radius_spotlight = int(10)

    targetfile = os.path.join(r'C:\_data\blur_script\target', f'{SOURCE_FN}_radius_{radius}.png')
    targetfile_spotlight = os.path.join(r'C:\_data\blur_script\target', f'{SOURCE_FN}_radius_spotlight_{radius_spotlight}.png')


    # md5_hashvalue = md5hash(SOURCE_FNP)
    # print(md5_hashvalue)


    if exists(targetfile) == False:
        image = Image.open(SOURCE_IMAGE)
        print(image, '\n', image.format, image.size, image.mode)

        # blurred_image = image.filter(ImageFilter.GaussianBlur(radius)).show()
        # unshrinked execution Execution time: 3.613839626312256 seconds
        # shrink 540 Execution time: 0.31098508834838867 seconds
        # shrink 1080 Execution time: 0.6337189674377441 seconds | rgb 0.634758710861206 seconds

        blurred_image = image.thumbnail((1080, 1080), Image.Resampling.LANCZOS)
        # blurred_image = image.convert('RGB')
        blurred_image = image.filter(ImageFilter.GaussianBlur(radius)).save(targetfile)
        blurred_image_spotlight = image.filter(ImageFilter.GaussianBlur(radius_spotlight)).save(targetfile_spotlight)

        # print(blurred_image, '\n', blurred_image.format, blurred_image.size, blurred_image.mode)
        # blurred_image = Image.open(SOURCE_IMAGE).filter(ImageFilter.GaussianBlur(radius))
        # blurred_image.save(targetfile)
        webbrowser.open(targetfile)
        webbrowser.open(targetfile_spotlight)

    else:
        print('already existing')
        webbrowser.open(targetfile)
        webbrowser.open(targetfile_spotlight)
   

    # get the end time
    et = time.time()

    # get the execution time
    elapsed_time = et - st
    print('Execution time:', elapsed_time, 'seconds')