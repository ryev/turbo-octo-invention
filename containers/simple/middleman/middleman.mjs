import { WebSocketServer} from "ws";
import redis from "redis";
import readline from "readline";

// Configuration: adapt to your environment
const WEB_SOCKET_PORT = 3000;
const REDIS_SERVER = "redis://localhost:6379";
const PUBSUB_CHANNEL = "video.tracker.1"

let exitFlag = false;
let showMsgFlag = false;

if (process.stdin.isTTY) {
    readline.emitKeypressEvents(process.stdin);
    process.stdin.setRawMode(true);

    process.stdin.on('keypress', (chunk,key) => { 
	if (key) {
		(key.name=='q'|| key.name=='c') && process.exit();	
		if (key.name=='m') {
			showMsgFlag = !showMsgFlag;	
			console.log(`showMsg: ${showMsgFlag}`);
		}
	}
    });
}

const redisClient = await redis.createClient(REDIS_SERVER)
	.on('error', err => console.log("Redis createClient Error", err))
	.connect();


// Create & Start the WebSocket server
const server = new WebSocketServer({ port : WEB_SOCKET_PORT });

// Register event for client connection
server.on('connection', async function connection(ws) {
	const subscriber = redisClient.duplicate();
	await subscriber.connect();
	await subscriber.subscribe(PUBSUB_CHANNEL, (msg,ch) => {
					ws.send(msg);
					if (showMsgFlag) console.log(msg);
					});
	console.log("subscribed");
	}
);

if (process.stdin.isTTY) {
console.log(`Running websocket server on port ${WEB_SOCKET_PORT} serving pubsub messages from
    ${REDIS_SERVER} on channel ${PUBSUB_CHANNEL}

	q - quit
	m - toggle message print`);
}
