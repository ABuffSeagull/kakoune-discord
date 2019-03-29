extern crate discord_rpc_client;

use discord_rpc_client::Client;
use std::{thread, time};

const CLIENT_ID: u64 = 561241836451004449;

fn main() {
    let mut client = Client::new(CLIENT_ID);

    let now = time::SystemTime::now();
    let epoc_secs = now
        .duration_since(time::UNIX_EPOCH)
        .expect("Epoch is after now?")
        .as_secs();

    client.start();
    client
        .set_activity(|act| {
            act.details("Testing!")
                .timestamps(|timestamp| timestamp.start(epoc_secs))
        })
        .expect("Failed to set activity");

    thread::sleep(time::Duration::from_secs(10));
}
