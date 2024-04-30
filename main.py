""" import cv2 as cv
import sys
import matplotlib.pyplot as plt
 
image_path = 'input_image.jpg'

img = cv.imread(image_path)

print("image shape:", img.shape)

gray_image = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

print("gray image shape:", gray_image.shape)

face_classifier = cv.CascadeClassifier(
    cv.data.haarcascades + "haarcascade_frontalface_default.xml"
)

face = face_classifier.detectMultiScale(
    gray_image, scaleFactor=1.1, minNeighbors=5, minSize=(40, 40)
)

for (x, y, w, h) in face:
    cv.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 4)

img_rgb = cv.cvtColor(img, cv.COLOR_BGR2RGB)

plt.figure(figsize=(20,10))
plt.imshow(img_rgb)
plt.axis('off')

plt.show()

print("end") """