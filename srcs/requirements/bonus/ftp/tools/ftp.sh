#!/bin/bash

echo "Username from env: $FTP_USR"
# 1. Create the user
# -m -d /var/www/wordpress: Sets their home directory directly to the WordPress volume
# -s /bin/bash: Gives them a standard shell
# (Errors hidden to keep logs clean during Docker restarts)
useradd -m -d /var/www/wordpress -s /bin/bash $FTP_USR 2>/dev/null

# 2. Set the password
# We take the username and password from your .env file and pipe them into the chpasswd tool
echo "$FTP_USR:$FTP_PWD" | chpasswd

# 3. Grant permissions
# We make the FTP user the official owner of the WordPress folder so they are allowed to upload and delete files
chown -R $FTP_USR:$FTP_USR /var/www/wordpress

# 4. The Docker Fix: Create the secure workspace at RUNTIME
mkdir -p /var/run/vsftpd/empty

# 4. Start the FTP Server
# The 'exec' command is critical. It replaces this bash script with the vsftpd program, making vsftpd the main process (PID 1) so Docker stays alive.
exec vsftpd /etc/vsftpd.conf
#sleep infinity



# echo "Username from env: $FTP_USR"
# useradd -m -d /var/www/wordpress -s /bin/bash $FTP_USR 2>/dev/null
# echo "$FTP_USR:$FTP_PWD" | chpasswd
# chown -R $FTP_USR:$FTP_USR /var/www/wordpress

# # Create the secure workspace at RUNTIME
# mkdir -p /var/run/vsftpd/empty

# echo "Starting vsftpd..."
# # 1. REMOVE 'exec' so the script does not destroy itself!
# vsftpd /etc/vsftpd.conf

# # 2. If vsftpd crashes, Bash will now reach this line and stay awake!
# echo "--- VSFTPD CRASHED OR BACKGROUNDED ---"
# sleep infinity