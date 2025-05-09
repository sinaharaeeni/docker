import requests
import threading

def send_request(url):
    try:
        response = requests.get(url)
        print(f"Request to {url} completed with status code: {response.status_code}")
    except Exception as e:
        print(f"Error making request to {url}: {str(e)}")

# Specify the URL you want to test
target_url = "http://whoami.sinaharaeeni.ir/"  # Replace with your local server URL

# Specify the number of requests you want to send
num_requests = 10000

# Create multiple threads to send requests concurrently
threads = []
for _ in range(num_requests):
    thread = threading.Thread(target=send_request, args=(target_url,))
    threads.append(thread)
    thread.start()

# Wait for all threads to finish
for thread in threads:
    thread.join()
