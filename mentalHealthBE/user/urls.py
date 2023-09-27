from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken.views import obtain_auth_token

from .views import *

app_name = 'users'

router = DefaultRouter()
router.register(r'', UserViewSet, basename = 'user')

urlpatterns = [
    path('register/', create_user, name='user_register'),
    path('register2/', Register.as_view(), name='user_register'),
    path('login/', Login.as_view(), name = 'login'),
    path('', UserAPIView.as_view(), name='user_detail'),
    path('profile/address/', include(router.urls)),
    path('get-csrf-token/', get_csrf_token, name='get-csrf-token'),
    path('api-auth-token', obtain_auth_token, name='api_token'),
    path('profile/', ProfileCreateView.as_view(), name='profile-create'),
    path('profile/<int:pk>/', ProfileRetrieveUpdateView.as_view(), name='profile-retrieve-update'),
]

urlpatterns += router.urls
