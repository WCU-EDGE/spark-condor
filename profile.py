import geni.portal as portal
import geni.rspec.pg as pg
import geni.rspec.igext as IG

pc = portal.Context()
request = pc.makeRequestRSpec()

tourDescription = \
    """
This profile provides the template for a compute node with Docker installed on Ubuntu 18.04
"""

#
# Setup the Tour info with the above description and instructions.
#  
tour = IG.Tour()
tour.Description(IG.Tour.TEXT, tourDescription)
request.addTour(tour)

prefixForIP = "192.168.1."
link = request.LAN("lan")

num_nodes = 3
for i in range(num_nodes):
    if i == 0:
        node = request.XenVM("head")
    elif i == 1:
        node = request.XenVM("submit_machine")
    else:
        node = request.XenVM("worker-" + str(i-1))
    node.cores = 4
    node.ram = 8192
    node.routable_control_ip = "true"
    node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU18-64-STD"
    iface = node.addInterface("if" + str(i))
    iface.component_id = "eth1"
    iface.addAddress(pg.IPv4Address(prefixForIP + str(i + 1), "255.255.255.0"))
    link.addInterface(iface)

    # setup Docker
    node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/install_docker.sh"))
    # setup Kubernetes
    node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/install_kubernetes.sh"))
    node.addService(pg.Execute(shell="sh", command="sudo swapoff -a"))

    # setup Condor
    node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/install_condor.sh"))
    if i == 0:
        node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/central_manager.sh"))
    elif i == 1:
        node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/submit_machine.sh"))
    else:
        node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/execute_machine.sh"))

    # setup Kubernetes
    if i == 0:
        node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/kube_manager.sh"))
    else:
        node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/script/kube_worker.sh"))

pc.printRequestRSpec(request)
