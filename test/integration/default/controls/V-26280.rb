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

control "V-26280" do
  title "The sites error logs must log the correct format."
  desc  "The server error logs are invaluable because they can also be used to
identify potential problems and enable proactive remediation. Log data can
reveal anomalous behavior such as “not found” or “unauthorized” errors that may
be an evidence of attack attempts. Failure to enable error logging can
significantly reduce the ability of Web Administrators to detect or remediate
problems. The LogFormat directive defines the format and information to be
included in the access log entries."
  impact 0.5
  tag "gtitle": "WA00612"
  tag "gid": "V-26280"
  tag "rid": "SV-33203r1_rule"
  tag "stig_id": "WA00612 A22"
  tag "fix_id": "F-29379r1_fix"
  tag "cci": []
  tag "nist": ["Rev_4"]
  tag "documentable": false
  tag "responsibility": "Web Administrator"
  tag "ia_controls": "ECAR-1, ECAR-2"
  tag "check": "Enter the following command:

grep \"LogFormat\" /usr/local/apache2/conf/httpd.conf.

The command should return the following value:

LogFormat \"%a %A %h %H %l %m %s %t %u %U \\\"%{Referer}i\\\" \" combined.

If the above value is not returned, this is a finding. "
  tag "fix": "Edit the httpd.conf file and add LogFormat \"%a %A %h %H %l %m %s
%t %u %U \\\"%{Referer}i\\\" \" combined"

  format1 = "%a %A %h %H %l %m %s %t %u %U \\\\\\%{Referer}i\\\\\\ combined"
  describe apache_conf("#{APACHE_CONF_DIR}/httpd.conf").LogFormat.map!{ |element| element.gsub(/"/, '') } do
    it { should include format1 }
  end
end
