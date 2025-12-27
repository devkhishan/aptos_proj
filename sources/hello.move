module hello_blockchain::hello_blockchain {
    use std::string;
    use std::signer;

    // Define a resource to hold a string
    struct MessageHolder has key {
        message: string::String,
    }

    // Function to set the message - 0xfaccc7b7167934fc3546fe1b78c157682e9fa783671cb41ffe3dd732cda4294f
    public entry fun set_message(account: &signer, msg_bytes: vector<u8>) acquires MessageHolder {
        let account_addr = signer::address_of(account);
        let message = string::utf8(msg_bytes);

        if (!exists<MessageHolder>(account_addr)) {
            move_to(account, MessageHolder { message });
        } else {
            let holder = borrow_global_mut<MessageHolder>(account_addr);
            holder.message = message;
        }
    }
}
