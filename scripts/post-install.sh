#!/bin/sh

echo "Adding default SSH key for $USERNAME user.."
mkdir -p "/Users/$USERNAME/.ssh"

cat << EOF > "/Users/$USERNAME/.ssh/authorized_keys"
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDY/apwGMmA6ZBnN7ezuNlpEhCmET1bkuyy1oKNo4/xDCyE2i8KAKBrSzKOGnjNNCtcQmVcslfJBizY0atX2o19WauZtgbNSsT8qCqqHZ3ha9riJW7ypxLh2wpTtFMfc78Sna+yA/ErWuQNMgKOFW7KU5S+sXtls1IfXloDSRm+q7GhmuwjLlN4Mk8y43mhyFe0ZO+NY09Xmc1yyy5w1urJuykFs6zcUkjQ5l3H5ZBPGJjDJ6KHXYsEcE6zDaa+4lZiWb7MaamU37W0Zm/ntIQUzDEP/XPOAC0NTdAsXI1dSltVX6NCLFUO9qHSSv9N9wPECuimJUt4wyYU4P1e//o5Gq0EIpNpiswEaJtlc9f0AEyzuQLdWYwtLW+ncIdK2Bm2nVCBYvBqQ2bB9cMdShVTEvTAlnSb3tavETxPTjXBefQaugsPeV67eEQhmeWValnQIcLtjd2JnktVHLw3bdH4cIUKsauE07TQzdkTyWRs9eyygz0kNMTtCq/wcMMuTGDv0Yhrc4lFNZ9OeHPmuMpx5CbnPhexaUXjqJq+KjLkBJ3DeWkS3anbYoK7UJrEQYYWPQjZcPj3vLHu4n1preO3uZ0fcrgtlwato20n83+sn0ieOgBz6t+jqekRyUFLCe/A401vUUlflGAm3N4UvbZfiLKq3qk2EPkKL+p4cC2ZPw==
EOF

chmod 700 "/Users/$USERNAME/.ssh"
chmod 600 "/Users/$USERNAME/.ssh/authorized_keys"
chown -R "$USERNAME" "/Users/$USERNAME/.ssh"

echo "Enabling password-less sudo..."
mkdir -p /etc/sudoers.d

cat << EOF > /etc/sudoers.d/password_less
ALL            ALL = (ALL) NOPASSWD: ALL
EOF

chmod 440 /etc/sudoers.d/password_less

echo "Creating a group for the user..."
dseditgroup -o create "$USERNAME"
dseditgroup -o edit -a "$USERNAME" "$USERNAME"
