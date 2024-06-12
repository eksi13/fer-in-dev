import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path
from tqdm import tqdm
from collections import Counter

import torch
from torch.utils.data import Dataset
import mediapipe as mp
from mediapipe import Image

import torch
from torch.utils.data import Dataset
from PIL import Image
import random

class Dataset(Dataset):
    def __init__(self, data_path, img_size, dataset, transform=None, phase='train'):
        self.data_path = Path(data_path)
        self.img_size = img_size
        self.transform = transform
        self.phase = phase
        self.dataset = dataset

        self.classes = self._get_classes()
        self.image_paths = self._get_image_paths()


    def _get_classes(self):
        return [f.name for f in (self.data_path / self.phase).iterdir() if f.is_dir()]
    

    def _get_image_paths(self):
        paths = list(self.data_path.rglob('*.jpg'))
        random.shuffle( paths )
        return paths


    def __len__(self):
        return len(self.image_paths)
    

    def __getitem__(self, idx):
        img = Image.open(self.image_paths[idx])
        img_path = self.image_paths[idx]

        if self.transform:
            img = self.transform(img)

        label = Path(img_path).parent.name

        return img, label
    

    def show_samples(self):
        fig = plt.figure(figsize=(20,20))

        for i in range(10):

            ax = fig.add_subplot(1, 10, i + 1)
            img, label = self.__getitem__(i)
            if img.ndim == 3:
                img = img.squeeze(0)
            img = img.numpy() if isinstance(img, torch.Tensor) else np.array(img)

            ax.imshow(img, cmap='gray')
            ax.set_title(label)
            ax.axis('off')

        plt.show()


    def show_distribution(self):
        labels_count = Counter([self.__getitem__(i)[1] for i in tqdm(range(len(self.image_paths)))])
        sorted_counts = sorted(labels_count.items())
        labels, counts = zip(*sorted_counts)

        plt.figure(figsize=(10, 3))
        bars = plt.bar(labels, counts, color='skyblue')
        plt.xlabel(f'{self.dataset}')
        plt.ylabel('Count')
        plt.title('Counts per Emotion Category')
        plt.xticks(rotation=45, ha='right')
        plt.grid(axis='y', linestyle='--', alpha=0.7)

        for bar, count in zip(bars, counts):
            plt.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.5, count,
                    ha='center', va='bottom', color='black', fontsize=8) 

        plt.tight_layout()
        plt.show()

    def get_cv2_img(self, idx):
        img_path = self.image_paths[idx]
        return cv2.imread(str(img_path))
