import pandas as pd
from pathlib import Path

BASE_PATH = Path('/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data/in/EmoReact')
LABEL_PATH = Path('/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data/in/EmoReact/EmoReact_V_1.0/Labels/test_labels.text')
ORIG_FOLDERS = ['Test/', 'Train/', 'Validation/']
LABEL_FILES = ['test_labels.text', 'train_labels.text/', 'validation_labels.text']


labels = ['Curiosity', 'Uncertainty', 'Excitement', 'Happiness', 'Surprise', 'Disgust', 'Fear', 'Frustration']



def create_folders(labels, base_path):
    for label in labels:
        label_path = base_path / Path(label)
        if not label_path.exists():
            label_path.mkdir(parents=True, exist_ok=True)

def read_labels(labels, label_path):
    df = pd.read_csv(str(label_path), header=None)
    df = df.drop(columns=[df.columns[-1]])
    df.columns = labels
    return df


#create_folders(labels, BASE_PATH)
df = read_labels(labels, LABEL_PATH)
#print(df)

for folder in ORIG_FOLDERS:
    folder_path = BASE_PATH / Path('EmoReact_V_1.0/Data') / folder
    for file_idx, file in enumerate(list(folder_path.rglob('*.mp4'))):
        print(file_idx, '\n', file)
        break
    break







""" 
def manage_and_create_paths(image_path, out_path):
    resP = out_path / image_path.parent.name / image_path.name
    if not resP.parent.exists():
        resP.parent.mkdir(parents=True, exist_ok=True)
    return resP.parent 
"""