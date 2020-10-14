class InventoryMailer < ApplicationMailer
    def send_return_inventory_request(recipients, inventory, subdomain, domain_name)
        @subdomain = subdomain
        @domain = domain_name
        @inventory = inventory
        mail(to: recipients.email, subject: "#{@inventory.user_name} ยื่นคำขอคืนพัสดุ")
    end

    def send_repair_inventory (recipients, inventory_repiar, subdomain, domain_name)
        @inventory_repiar = inventory_repiar
        @recipients = recipients
        @domain = domain_name
        @subdomain = subdomain
        mail(to: recipients.email, subject: "#{@inventory_repiar.employee_name} ยื่นคำขอซ่อมพัสดุ")
    end

    def send_request_inventory (recipients, inventories, subdomain, domain_name)
        @inventories = inventories
        @recipients = recipients
        @domain = domain_name
        @subdomain = subdomain
        mail(to: recipients.email, subject: "#{@inventories.user_name} ยื่นคำขอใช้พัสดุ")
    end

    def send_new_inventory (recipients, inventories, subdomain, domain_name)
        @inventories = inventories
        @recipients = recipients
        @domain = domain_name
        @subdomain = subdomain
        mail(to: recipients.email, subject: "#{@inventories.user_name} ยื่นคำขอเบิกพัสดุ")
    end

    def send_reject_inventory_request(requester, inventory, recipient)
        @inventory = inventory
        @recipient = recipient
        @requester = requester
        mail(to: requester.email, subject: "ผลการยื่นคำขอใช้พัสดุ #{@inventory.item_name}")
    end

    def send_approve_inventory_request(requester, invetory_request, recipient)
        @invetory_request = invetory_request
        @recipient = recipient
        @requester = requester
        mail(to: requester.email, subject: "ผลการยื่นคำขอใช้พัสดุ #{@invetory_request.item_name}")
    end

    def send_approve_inventory_new(requester, invetory_request, recipient)
        @invetory_request = invetory_request
        @recipient = recipient
        @requester = requester
        mail(to: requester.email, subject: "ผลการยื่นคำขอเบิกพัสดุ #{@invetory_request.item_name}")
    end

    def send_reject_inventory_repair (requester, inventory_repiars, recipients)
        @inventory_repiars = inventory_repiars
        @recipients = recipients
        @requester = requester
        mail(to: requester.email, subject: "ผลการยื่นคำขอซ่อมเบิกพัสดุ #{@inventory_repiars.item_name}")
    end

    def send_approve_inventory_repair (requester, invetory_repair, recipients)
        @invetory_repair = invetory_repair
        @recipients = recipients
        @requester = requester
        mail(to: requester.email, subject: "ผลการยื่นคำขอซ่อมเบิกพัสดุ #{@invetory_repair.item_name}")
    end

    def send_approve_return_inventory(requester, inventory, recipient)
        @requester = requester
        @inventory = inventory
        @recipient = recipient
        mail(to: requester.email, subject:"ผลการยื่นคำขอคืนพัสดุ #{@inventory.item_name}")
    end

end