[TOC]

---



[전체 코드 보기](https://github.com/jungeunlee95/python-mysite)



---

# [django-mysite프로젝트] 3 - 방명록 기능 추가

---

## [1] application geustbook 추가

Terminal -> `python manage.py startapp guestbook`



## [2] settings.py app 추가

```python
INSTALLED_APPS = [
    ...
    'guestbook',
    ...
]
```



## [3] Model 정의

**guestbook/models.py**

```python
from django.db import models

# Create your models here.
class Guestbook(models.Model):
    name = models.CharField(max_length=20)
    password = models.CharField(max_length=32)
    contents = models.TextField()
    reg_date = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'Guestbook({self.name}, {self.password}. {self.contents}, {self.reg_date}'
```



**admin.py**

```python
from django.contrib import admin

# Register your models here.
from geustbook.models import Guestbook

admin.site.register(Guestbook)
```



## [4] migrate

`python manage.py makemigrations`

`python manage.py migrate`





## [5] 방명록 기능 추가하기

**urls.py** 매핑 추가

```python
from django.contrib import admin
from django.urls import path
import guestbook.views as guestbook_views

urlpatterns = [
    ...
    path('guestbook/list', guestbook_views.list),
    path('guestbook/write', guestbook_views.write),
    path('guestbook/deleteform/<int:id>', guestbook_views.deleteform),
    path('guestbook/delete', guestbook_views.delete),
	...
]

```



**views.py**

```python
from django.http import HttpResponseRedirect
from django.shortcuts import render

# Create your views here.
from guestbook.models import Guestbook


def list(request):
    guestbooklist = Guestbook.objects.all().order_by('-reg_date')
    data = {'guestbooklist': guestbooklist}
    return render(request, 'guestbook/list.html', data)

def write(request):
    guestbook = Guestbook()
    guestbook.name = request.POST['name']
    guestbook.password = request.POST['password']
    guestbook.contents = request.POST['contents']
    guestbook.save()

    return HttpResponseRedirect('list')

def deleteform(request, id=0):
    return render(request, 'guestbook/deleteform.html', {'id':id})

def delete(request):
    id = request.POST['no']
    password = request.POST['password']

    guestbook = Guestbook.objects.filter(id=id)
    if guestbook[0].password == password:
        guestbook.delete()

    return HttpResponseRedirect('list')
```



**templates/guestbook/deleteform.html**

```html
{% extends '../base.html' %}

{% block csslink %}
<link href="/assets/css/guestbook.css" rel="stylesheet" type="text/css">
{% endblock%}

{% block content %}
<div id="guestbook" class="delete-form">
	<form method="post" action="/guestbook/delete">
		{% csrf_token %}
		<input type='hidden' name="no" value="{{ id }}">
		<label>비밀번호</label>
		<input type="password" name="password">
		<input type="submit" value="확인">
	</form>
	<a href="/guestbook">방명록 리스트</a>
</div>
{% endblock%}
```



**templates/guestbook/list.html**

```html
{% extends '../base.html' %}

{% block csslink %}
<link href="/assets/css/guestbook.css" rel="stylesheet" type="text/css">
{% endblock%}

{% block content %}
<div id="guestbook">
	<form action="/guestbook/write" method="post">
		{% csrf_token %}
		<table>
			<tr>
				<td>이름</td><td><input type="text" name="name"></td>
				<td>비밀번호</td><td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td colspan=4><textarea name="contents" id="contents"></textarea></td>
			</tr>
			<tr>
				<td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
			</tr>
		</table>
	</form>
	<ul>
		<li>
			{% for guestbook in guestbooklist %}
			<table>
				<tr>
					<td>[{{ forloop.revcounter }}]</td>
					<td>{{ guestbook.name }}</td>
					<td>{{ guestbook.reg_date|date:'Y-m-d H:i' }}</td>
					<td><a href="/guestbook/deleteform/{{guestbook.id}}">삭제</a></td>
				</tr>
				<tr>
					<td colspan=4>
					{{ guestbook.contents|linebreaks }}
					</td>
				</tr>
			</table>
			<br>
			{% endfor %}
			<br>
		</li>
	</ul>
</div>
{% endblock%}
```



## [6] Test

![1561017895220](assets/1561017895220.png)

> [장고 템플릿 기능 참고!]
>
> 1, 노란색 네모의 list index 처리를 위해서 
>
> `<td>[{{ forloop.revcounter }}]</td>` 코드를 이용해서 돌고있는 loop의 count를 reverse해서 넣어주었다.
>
> 2, 초록색 네모의 날짜 데이터의 형식은
>
> `{{ guestbook.reg_date|date:'Y-m-d H:i' }}` 이렇게 처리하였다.
>
> 3, 파란색 네모의 `\n` 처리는
>
> `{{ guestbook.contents|linebreaks }}` 로 처리하였다.

[장고 템플릿 기능 참조](https://docs.djangoproject.com/en/2.2/ref/templates/builtins/)