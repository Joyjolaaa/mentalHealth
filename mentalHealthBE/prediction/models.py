from django.db import models
from keras.models import load_model
import numpy as np


model_path = 'model/dumped.keras'  # Replace with the actual path
rnn_model = load_model(model_path)

def cnn_predict(input_data):
    input_data = np.array(input_data)  # Ensure input_data is a numpy array
    predictions = rnn_model.predict(input_data)
    return predictions.tolist()
