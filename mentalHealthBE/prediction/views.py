from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import CNNPredictionSerializer
from rest_framework.decorators import api_view, permission_classes, action
from rest_framework.permissions import *
from rest_framework.decorators import *
from django.views.decorators.csrf import csrf_exempt
from .models import cnn_predict
from keras.models import load_model
from rest_framework import status, permissions
from rest_framework.response import Response
from django.http import JsonResponse


# Create your views here.


class ModelInputInfoView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request):
        model_path = 'model/dumped.keras'  # Replace with the actual path
        rnn_model = load_model(model_path)

        input_layer = rnn_model.input
        input_shape = input_layer.shape.as_list()
        input_data_type = input_layer.dtype.name

        response_data = {
            'input_shape': input_shape,
            'input_data_type': input_data_type,
        }

        return Response(response_data)


class CNNPredictionView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def post(self, request, *args, **kwargs):
        serializer = CNNPredictionSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        input_data = serializer.validated_data['input_data']
        predictions = cnn_predict(input_data)

        return Response({'predictions': predictions})


# @csrf_exempt
# @api_view(['POST'])
# @permission_classes([AllowAny])
# def predictions(request):
#     if request.method == 'POST':
#         print(request.data)  # Print the received data for debugging
#         input_data = request.data.get('input_data')
#         predictions = cnn_predict(input_data)
#         return Response({'predictions': predictions})


# @csrf_exempt
# @api_view(['POST'])
# @permission_classes([AllowAny])
# def predictions(request):
#     if request.method == 'POST':
#         print(request.data)  # Print the received data for debugging
#         input_data = request.data.get('input_data')
#     input_array = []  # Create an array to hold the input data

#     for input_dict in input_data:
#         input_values = list(input_dict.values())
#         input_array.append(input_values)

#     # Use the array in your prediction function
#     predictions = cnn_predict(input_array)
#     return Response({'predictions': predictions})


@csrf_exempt
@api_view(['POST'])
@permission_classes([AllowAny])
def predictions(request):
    if request.method == 'POST':
        print(request.data)  # Print the received data for debugging
        input_data = request.data.get('input_data')
    
    input_array = []  # Create an array to hold the input data

    for input_dict in input_data:
        input_values = list(input_dict.values())
        input_array.append(input_values)

    # Use the array in your prediction function
    predictions = cnn_predict(input_array)
    
    # Translate predicted probabilities to class names
    class_names = ['Waterfall', 'Spiral', 'V model', 'Prototype', 'Incremental', 'Iterative', 'RAD', 'Kanban', 'RUP', 'XP', 'Scrum', 'DSDM', 'Big Bang', 'Lean', 'DevOps',]  # Replace with actual class names
    readable_predictions = []
    for prediction_array in predictions:
        class_index = max(enumerate(prediction_array), key=lambda x: x[1])[0]
        class_name = class_names[class_index]
        readable_predictions.append(class_name)
    
    return JsonResponse({'predictions': readable_predictions})

