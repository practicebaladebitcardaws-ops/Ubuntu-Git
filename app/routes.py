from flask import Blueprint, render_template, request, session, redirect, url_for, flash
from .models import authenticate

bp = Blueprint('main', __name__)

@bp.route('/')
def index():
    if 'user' in session:
        return render_template('dashboard.html')
    return redirect(url_for('main.login'))

@bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if authenticate(username, password):
            session['user'] = username
            return redirect(url_for('main.index'))
        flash('Invalid credentials')
    return render_template('login.html')

