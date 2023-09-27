from django.conf import settings
from django.core.exceptions import ValidationError
from django.db import models
from django.utils import timezone
from django.utils.translation import gettext as _
from rest_framework.exceptions import NotAcceptable
from django.utils.crypto import get_random_string
import datetime
from django.contrib.auth.models import AbstractUser, User
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.db.models.signals import post_save
from .models import *
from django.dispatch import receiver
from .managers import UserManager
from . import signals



# Signal to create a profile when a new user is registered
@receiver(post_save, sender=User)
def create_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

# Signal to save the profile when the user is saved
@receiver(post_save, sender=User)
def save_profile(sender, instance, **kwargs):
    instance.profile.save()
    


class User(AbstractUser):
    username = None
    email = models.EmailField(_("email"), max_length=250, unique=True)
    create_at = models.DateTimeField(auto_now_add=True)
    phone_number = models.BigIntegerField(unique=True, null=True, blank=True)


    USERNAME_FIELD = 'email'

    objects = UserManager()
    REQUIRED_FIELDS = []
    
    class Meta:
        swappable = 'AUTH_USER_MODEL'


    def __str__(self):
        return str(self.first_name) or ''
    
    # Now, connect the signal handlers to the User model
    post_save.connect(create_profile, sender=User)
    post_save.connect(save_profile, sender=User)
    
    
class Profile(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        related_name='profile',
        on_delete=models.CASCADE
    )
    avatar = models.ImageField(upload_to='avatar', blank=True)
    bio = models.CharField(max_length=200, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-created_at', )

    def __str__(self):
        return str(self.user.get_full_name())

