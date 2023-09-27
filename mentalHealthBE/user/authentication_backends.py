from django.contrib.auth.backends import ModelBackend
from .models import User

class EmailOrPhoneNumberBackend(ModelBackend):
    def authenticate(self, request, email_or_phone=None, password=None, **kwargs):
        # Try to find the user by email
        user = User.objects.filter(email=email_or_phone).first()

        # If user is not found, try to find the user by phone number
        if user is None and email_or_phone is not None:
            try:
                phone_number = int(email_or_phone)
                user = User.objects.filter(phone_number=phone_number).first()
            except ValueError:
                pass

        # Try to authenticate the user with the provided password
        if user and user.check_password(password):
            return user

        return None
