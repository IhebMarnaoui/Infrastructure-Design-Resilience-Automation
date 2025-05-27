import logging
from flask import Flask, request
import subprocess

app = Flask(__name__)
logging.basicConfig(filename='/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/webhook.log', level=logging.INFO)

@app.route('/failover', methods=['POST'])
def failover():
    data = request.json
    logging.info("Received alert: %s", data)
    alerts = data.get('alerts', [])
    for alert in alerts:
        alertname = alert['labels'].get('alertname')
        try:
            if alertname == "OnPremDown":
                logging.info("Executing start_cloud.sh")
                subprocess.call(["/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/start_cloud.sh"])
            elif alertname == "OnPremUp":
                logging.info("Executing stop_cloud.sh")
                subprocess.call(["/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/stop_cloud.sh"])
        except Exception as e:
            logging.error("Error handling alert: %s", str(e))
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=6000)
