[containers]
%{ for ct in containers ~}
${ct.hostname} ansible_host=${ct.ipv4_address} ansible_user=root
%{ endfor ~}
