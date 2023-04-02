from PIL import ImageFilter,Image,ImageOps,ImageEnhance
import webbrowser
import os


SOURCE_FP = "C:\data\_test"
SOURCE_FN = "test"
SOURCE_IMAGE = fr'{SOURCE_FP}\{SOURCE_FN}.jpg' # when in a loop listitem.absolute(int).listitem.art(fanart), else argument



if __name__ == '__main__':
    radius = float(15.0) # get a differ between strong and soft radius common=soft vs spotlight = strong
    targetfile = os.path.join('C:\data\_test', f'{SOURCE_FN}_gaussian_{radius}.png') # 2 folders to differ soft vs common


    # if not stored create
    image = Image.open(SOURCE_IMAGE)
    print(image, '\n', image.format, image.size, image.mode)

    '''
        blur filter
    '''
    blurred_image = Image.open(SOURCE_IMAGE).filter(ImageFilter.GaussianBlur(radius))
    # print(blurred_image, '\n', blurred_image.format, blurred_image.size, blurred_image.mode)
    blurred_image.save(targetfile)

    # webbrowser.open(r"%s" % blurred_image)
    webbrowser.open(targetfile)

    '''
        UnsharpMask filter
    '''
    targetfile2 = os.path.join('C:\data\_test', f'{SOURCE_FN}_unsharpmask_{radius}.png')

    blurred_image = Image.open(SOURCE_IMAGE).filter(ImageFilter.UnsharpMask(radius, 200))
    # print(blurred_image, '\n', blurred_image.format, blurred_image.size, blurred_image.mode)
    blurred_image.save(targetfile2)

    # webbrowser.open(r"%s" % blurred_image)
    webbrowser.open(targetfile2)

'''
https://pillow.readthedocs.io/en/stable/reference/ImageFilter.html#module-PIL.ImageFilter
- class PIL.ImageFilter.UnsharpMask(radius=2, percent=150, threshold=3)
'''
