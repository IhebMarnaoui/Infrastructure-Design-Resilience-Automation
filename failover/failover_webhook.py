from flask import Flask, request
import subprocess
import logging

app = Flask(__name__)

logging.basicConfig(filename='/home/ubuntu/failover/webhook.log', level=logging.INFO)

@app.route('/failover', methods=['POST'])
def failover():
    try:
        data = request.json
        app.logger.info(f"Received alert: {data}")

        alerts = data.get('alerts', [])
        for alert in alerts:
            labels = alert.get('labels', {})
            alertname = labels.get('alertname')

            if alertname == "OnPremDown":
                subprocess.call(["/home/ubuntu/failover/start_cloud.sh"])
            elif alertname == "OnPremUp":
                subprocess.call(["/home/ubuntu/failover/stop_cloud.sh"])

        return "OK", 200

    except Exception as e:
        app.logger.error(f"Error handling alert: {e}")
        return "Internal Server Error", 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=6000)
