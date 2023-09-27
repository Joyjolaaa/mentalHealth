from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import *
# Register your models here.

@admin.register(User)
class UsersAdmin(ImportExportModelAdmin):
    list_display = ('email', 'phone_number', 'username', 'first_name', 'last_name')
    search_fields = ['username', 'first_name', 'last_name']

@admin.register(Profile)
class UsersAdmin(ImportExportModelAdmin):
    list_display = ('user', 'bio','created_at',)
    list_filter = ('created_at',)
    search_fields = ['user',]



admin.site.site_header = "SDLC Administration Dashboard"