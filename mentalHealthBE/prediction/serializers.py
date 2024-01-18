from rest_framework import serializers


class CNNPredictionSerializer(serializers.Serializer):
    input_data = serializers.ListField(child=serializers.FloatField())
