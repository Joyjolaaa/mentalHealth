from rest_framework import serializers
from .models import *
from django.conf import settings
from django.contrib.auth import get_user_model, authenticate
from django.utils.translation import gettext as _
from rest_framework.validators import UniqueValidator
import random
from datetime import datetime, timedelta
from .exceptions import (
    AccountNotRegisteredException,
    InvalidCredentialsException,
    AccountDisabledException,
)
from rest_framework import serializers


class BigIntegerField(serializers.Field):
    def to_representation(self, value):
        return str(value)

    def to_internal_value(self, data):
        try:
            return int(data)
        except (TypeError, ValueError):
            raise serializers.ValidationError('Invalid integer value')


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = '__all__'


class UserRegistrationSerializer(serializers.ModelSerializer):
    first_name = serializers.CharField()
    last_name = serializers.CharField()
    phone_number = serializers.CharField()
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)


    class Meta:
        model = User
        fields = ['first_name', 'last_name',
                  'email', 'phone_number', 'password']

    def validate(self, validated_data):
        email = validated_data.get('email', None)
        phone_number = validated_data.get('phone_number', None)

        if not (email or phone_number):
            raise serializers.ValidationError(
                _("Enter an email or a phone number."))

        return validated_data

    def get_cleaned_data_extra(self):
        return {
            'phone_number': self.validated_data.get('phone_number', ''),
            "first_name": self.validated_data.get("first_name", ""),
            "last_name": self.validated_data.get("last_name", ""),
        }

    def create_extra(self, user, validated_data):
        user.first_name = validated_data.get("first_name")
        user.last_name = validated_data.get("last_name")
        user.save()

        phone_number = validated_data.get("phone_number")

        user.phone_number = phone_number
        user.save()

    def custom_signup(self, request, user):
        self.create_extra(user, self.get_cleaned_data_extra())

    def to_internal_value(self, data):
        """
        Perform the validation and conversion of input data.
        """
        if 'phone_number' in data:
            # Normalize the phone number input
            phone_number = self.fields['phone_number'].to_internal_value(
                data['phone_number'])
            data['phone_number'] = phone_number

        return super().to_internal_value(data)

    def create(self, validated_data):
        phone_number = self.context.get('phone_number')

        # Create and save the User instance
        user = User.objects.create_user(
            email=validated_data.get('email'),
            password=validated_data.get('password'),
            phone_number=validated_data.get('phone_number'),
        )

        # Save any additional data
        user.first_name = validated_data.get('first_name')
        user.last_name = validated_data.get('last_name')
        user.save()

        # TODO: call send_otp function
        # send_otp(phone_number, otp)
        return user


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ('avatar', 'bio',)


