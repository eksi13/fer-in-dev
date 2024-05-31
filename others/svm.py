import time
import argparse
import os
import sys
if sys.version_info >= (3, 0):
        import _pickle as cPickle
else:
        import cPickle
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score

from data_loader import load_data 
from parameters import DATASET, TRAINING, HYPERPARAMS

def train(epochs=HYPERPARAMS.epochs, random_state=HYPERPARAMS.random_state, 
          kernel=HYPERPARAMS.kernel, decision_function=HYPERPARAMS.decision_function, gamma=HYPERPARAMS.gamma, train_model=True):

        if train_model:
                data, validation = load_data(validation=True)
        else:
                data, validation, test = load_data(validation=True, test=True)
        
        if train_model:
            model = SVC(random_state=random_state, max_iter=epochs, kernel=kernel, decision_function_shape=decision_function, gamma=gamma)

            
            model.fit(data['X'], data['Y'])

            if TRAINING.save_model:
                with open(TRAINING.save_model_path, 'wb') as f:
                        cPickle.dump(model, f)

            validation_accuracy = evaluate(model, validation['X'], validation['Y'])
            return validation_accuracy
        else:
            if os.path.isfile(TRAINING.save_model_path):
                with open(TRAINING.save_model_path, 'rb') as f:
                        model = cPickle.load(f)
            else:
                exit()

            validation_accuracy = evaluate(model, validation['X'],  validation['Y'])
            test_accuracy = evaluate(model, test['X'], test['Y'])
            return test_accuracy

def evaluate(model, X, Y):
        predicted_Y = model.predict(X)
        accuracy = accuracy_score(Y, predicted_Y)
        return accuracy

# parse arg to see if we need to launch training now or not yet
parser = argparse.ArgumentParser()
parser.add_argument("-t", "--train", default="no", help="if 'yes', launch training from command line")
parser.add_argument("-e", "--evaluate", default="no", help="if 'yes', launch evaluation on test dataset")
parser.add_argument("-m", "--max_evals", help="Maximum number of evaluations during hyperparameters search")
args = parser.parse_args()
if args.train=="yes" or args.train=="Yes" or args.train=="YES":
        train()
if args.evaluate=="yes" or args.evaluate=="Yes" or args.evaluate=="YES":
        train(train_model=False)