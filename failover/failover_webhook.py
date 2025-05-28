from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/failover', methods=['POST'])
def failover():
    data = request.json
    alerts = data.get('alerts', [])
    for alert in alerts:
        alertname = alert['labels'].get('alertname')
        try:
            if alertname == "OnPremDown":
                subprocess.call(["/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/start_cloud.sh"])
            elif alertname == "OnPremUp":
                subprocess.call(["/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/stop_cloud.sh"])
        except Exception:
            pass  # Silently ignore errors for now
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=6000)
