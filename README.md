### Small hacks applied on the following projects to get movenet detections to drive a webgl fluid simulation.
  [Pose detection](https://github.com/geaxgx/depthai_movenet)
  
  [Visualization](https://github.com/PavelDoGreat/WebGL-Fluid-Simulation)

---

You may be able to hack on MoveNet and other models with your browser/webcam.
[demo](https://storage.googleapis.com/tfjs-models/demos/pose-detection/index.html?model=movenet)

The source (and models) are at https://github.com/tensorflow/tfjs-models.git

---

### Context
* This quite basic example is just to help show how one might leverage and connect ome good work out there to make something expressive and your own.
* It is not recommended to use this hacked code as a basis for any real project.

---

### So many cool things to look into ....
* https://msp.ucsd.edu/
* https://experiments.withgoogle.com/collection/chrome
* https://webglsamples.org/
* https://github.com/search?q=awesome%20visualization&type=repositories
* https://github.com/search?q=awesome+music+generation&type=repositories

---
### How to get the demo working locally on your Mac
If participants get this working locally, it may afford more parallel development of your group's ideas.  Some can be working on different sensor input feeds into the pubsub server.  Others can work on tranforming/combining events into other kinds of events (for example, leveraging generative ai).  And yet others may work on how to consume those events to make cool aural, video, mechatronic, vr or other sensory output that helps communicate the artistic vision. I imagine the group may go beyond the simple event collection/distribution architecture perhaps with the routing of streams of high-fidelity capture.  Even in those scenarios, a low-latency pubsub facility might aid in coordination.  
* Get depthai installed (usu. in an environment, ex. conda)
  * Test that camera works with some of the demos there
* Install docker
  * Test with a sample container run.   
* Clone this repository and change directory into it
  * `git clone https://github.com/ryev/turbo-octo-invention && cd turbo-octo-invention`
  * Note that this repository has some scripts which somewhat document the next steps
* Build the container image that has the middleware for the demo
  * `scripts/build-0-servers-container.sh demoimage`
  * Note: "demoimage" above is an arbitrary name.  It tags the container image so you can refer to it later by that name.
  * Once this container image is built, it does not have to be built again if you need to run the demo repeatedly.  The container image is persistent.
* Run the middleware servers.  Using docker spin up a container based on that image you built above.
  * `scripts/run-1-servers-container.sh demoimage`
  * Note: If you changed the name of the image in the build step above be sure to use that new name here.
  * This should show some logging with successful starts of nginx (webserver), redis (in-memory db, here used for pubsub), and middleman (custom node server that mediates websocket connections and pubsub subscription)
  * The terminal is now tied up with this container run.  There are different ways to configure this behavior, but for now just open a new terminal for the next steps.
* Open a new terminal window and change to this repo directory
  * Command-N is a shortcut to start another terminal
  * `cd turbo-octo-invention`
* Start the browser
  *  `scripts/run-2-browser-viz.sh`
  *  This launches safari on http://localhost -- the default fluid demo should display.  Of course, one can just launch a browser and go to http://localhost instead of running this script.
* Start the MoveNet pose camera detection
  * **_Activate the environment with depthai in it_ -- from the first step**
  * `scripts/run-3-camera.sh`
* The detection of a nose should show up on the fluid simulation visualization.
  * Perhaps adjust the windows so you can see both the MoveNet pose detection and the web fluid simulation simultaneously.

* Shutdown
  * With the MoveNet Pose window selected, hit 'q'
  * With the terminal window that was used to run the middleware container (which should have some log output), hit 'ctrl-c'
  * Close the safari tab loaded with http://localhost

If you need to rerun the demo, be sure docker is available and run the steps above starting at "Run the middleware servers" from a terminal at the repo directory. In the scripts directory there's an example script `run-demo-again.sh` that takes the container image and the conda depthai environment names as arguments that executes these steps.  The all the steps are outlined above because doing it manually, at least once, should give a better understanding of what's going on to the uninitiated.

---
To do
- [x] Add "How to" to get demo working on laptop
- [ ] Add websocket middleware for publishers
- [ ] Demo with browser/webcam detection instead of oak-d-lite
