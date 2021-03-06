APACHE_HOME= attribute(
  'apache_home',
  description: 'location of apache home directory',
  default: '/etc/httpd'
)

APACHE_CONF_DIR= attribute(
  'apache_conf_dir',
  description: 'location of apache conf directory',
  default: '/etc/httpd/conf'
)

APACHE_LOG_DIR= attribute(
  'apache_log_dir',
  description: 'location of apache log directory',
  default: '/etc/httpd/logs'
)

control "V-26282" do
  title "The LogLevel directive must be enabled."
  desc  "The server error logs are invaluable because they can also be used to
identify potential problems and enable proactive remediation. Log data can
reveal anomalous behavior such as “not found” or “unauthorized” errors that may
be an evidence of attack attempts. Failure to enable error logging can
significantly reduce the ability of Web Administrators to detect or remediate
problems. While the ErrorLog directive configures the error log file name, the
LogLevel directive is used to configure the severity level for the error logs.
The log level values are the standard syslog levels: emerg, alert, crit, error,
warn, notice, info and debug."
  impact 0.5
  tag "gtitle": "WA00620"
  tag "gid": "V-26282"
  tag "rid": "SV-33207r1_rule"
  tag "stig_id": "WA00620 A22"
  tag "fix_id": "F-29385r1_fix"
  tag "cci": []
  tag "nist": ["Rev_4"]
  tag "documentable": false
  tag "responsibility": "Web Administrator"
  tag "ia_controls": "ECAR-1"
  tag "check": "Enter the following command:

grep \"LogLevel\" /usr/local/apache2/conf/httpd.conf

The command should return the following value:

LogLevel warn

If the above value is not returned, this is a finding.
Note:  If LogLevel is set to error, crit, alert, or emerg which are higher
thresholds this is not a finding.
"
  tag "fix": "Edit the httpd.conf file and add the value LogLevel warn."

  describe apache_conf("#{APACHE_CONF_DIR}/httpd.conf") do
    its('LogLevel') { should cmp 'warn' }
  end
end
