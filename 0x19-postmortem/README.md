# Postmortem: Web Stack Debugging Project Outage

---

## Issue Summary

**Duration:** August 10, 2024, 14:30 UTC - August 10, 2024, 16:15 UTC (1 hour and 45 minutes)

**Impact:** The outage disrupted the user authentication service, preventing about 75% of our users from logging into the platform. Those already logged in experienced sluggish performance and occasional disconnections.

**Root Cause:** A configuration error in the Nginx load balancer caused an infinite loop of requests between the load balancer and the application server, overwhelming the server and causing it to crash.

---

## Timeline

- **14:30 UTC:** Our monitoring system flagged a significant spike in response times, coupled with a sharp drop in successful login attempts.
- **14:32 UTC:** The on-call engineer was notified by the monitoring alert and began investigating.
- **14:35 UTC:** The initial focus was on the database, as it was suspected that high traffic might be causing an overload.
- **14:45 UTC:** After checking the database metrics and finding no issues, the database was ruled out as the cause.
- **14:50 UTC:** The issue was escalated to the network operations team, who began looking into the load balancer and network traffic.
- **15:00 UTC:** Misleading logs pointed to potential problems with the application server's session handling, prompting further investigation in that area.
- **15:15 UTC:** The team noticed an unusually high volume of requests passing through the load balancer.
- **15:30 UTC:** It was discovered that a recent change to the Nginx load balancer configuration had mistakenly created an infinite loop of requests between the load balancer and the application server.
- **15:45 UTC:** The configuration was corrected, and the load balancer was restarted.
- **16:00 UTC:** Services began to stabilize, with login success rates returning to normal levels.
- **16:15 UTC:** Full service was restored, and no further issues were detected by the monitoring system.

---

## Root Cause and Resolution

**Root Cause:** The root cause was a faulty Nginx load balancer configuration that created a routing loop, causing requests to endlessly cycle between the load balancer and the application server. This loop consumed all available server resources, leading to the outage.

**Resolution:** Once the loop was identified, the team corrected the Nginx configuration by removing the incorrect route. The load balancer was then restarted, which immediately stabilized the system. The team monitored the service for an hour to ensure the issue was fully resolved.

---

## Corrective and Preventative Measures

**Improvements/Fixes:**

1. **Stricter Configuration Review:** We need to tighten our review process for configuration changes, including mandatory peer reviews and testing changes in a staging environment before deploying them to production.
2. **Enhanced Monitoring:** We plan to implement more detailed monitoring of the load balancer and application server to catch unusual traffic patterns, like infinite loops, earlier.
3. **Better Documentation:** Our Nginx configuration documentation will be updated to clearly outline potential pitfalls and best practices to avoid similar errors.

**Task List:**

1. **Patch Nginx Configuration:** Review the current Nginx setup and patch any potential vulnerabilities to prevent similar routing issues.
2. **Implement Monitoring for Traffic Patterns:** Set up monitoring specifically for detecting abnormal traffic patterns that could indicate issues like infinite loops.
3. **Postmortem Review:** Organize a review meeting with the engineering and network operations teams to discuss the incident, learn from it, and ensure all corrective measures are in place.
4. **Automate Testing:** Work on automating the testing of Nginx configuration changes to catch potential errors before they affect the production environment.

---

This postmortem captures the events and actions surrounding the outage. Moving forward, our goal is to improve the robustness of our processes and prevent similar issues from occurring again.

