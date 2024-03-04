[containers]
%{ for ct in containers ~}
${ct.hostname} ansible_host=${ct.ipv4_address} ansible_user=root
%{ endfor ~}

[managers]
%{ for manager in managers ~}
${manager.name} ansible_host=${manager.ip} ansible_user=${vm_user}
%{ endfor ~}

[workers]
%{ for worker in workers ~}
${worker.name} ansible_host=${worker.ip} ansible_user=${vm_user}
%{ endfor ~}

[cluster:children]
managers
workers
