from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/failover', methods=['POST'])
def failover():
    data = request.json
    alerts = data.get('alerts', [])
    for alert in alerts:
        alertname = alert['labels'].get('alertname')
        status = alert.get('status')  # firing or resolved

        try:
            if alertname == "OnPremDown" and status == "firing":
                subprocess.call(["/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/start_cloud.sh"])
            elif alertname == "OnPremDown" and status == "resolved":
                subprocess.call(["/home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/stop_cloud.sh"])
        except Exception as e:
            print("Error:", e)

    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=6000)
