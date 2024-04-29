import cv2

imagePath = './photo.png'

img = cv2.imread(imagePath)

print(img.shape)