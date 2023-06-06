# Importing required libraries
from flask import Flask
import socket, json
from flask import jsonify

# Creating a Flask instance
app = Flask(__name__)

# Defining the route for root URL (i.e. "/") and function to get IP Address
@app.route('/')
def get_ip():
  # Get the hostname of the local machine
  hostname = socket.gethostname()
  # Get the IP address corresponding to the hostname
  get_ip_address = socket.gethostbyname(hostname)
  # Return the IP address
  return get_ip_address

# Defining the route for "/health" URL and function to check application health status
@app.route('/health')
def get_app_name():
  # Return a JSON response indicating the application is healthy with success code 200
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'}

# Check if this script is running as the main program
if __name__ == '__main__':
  # Run the Flask application on IP "0.0.0.0" and port no "8080"
  app.run(host="0.0.0.0", port="8080")
