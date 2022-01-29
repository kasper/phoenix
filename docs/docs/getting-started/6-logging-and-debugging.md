# Logging and Debugging

To log messages, use `Phoenix.log`. The messages are delivered to the Console (app). You can filter logs by process by searching for “Phoenix”. You can also follow the logs from a terminal by running `log stream --process Phoenix`.

To debug your configuration, use Safari’s Web Inspector. You can attach to the context from Safari’s “Develop” menu under your devices name. Read a more comprehensive [instruction](https://github.com/kasper/phoenix/wiki/Attaching-to-Web-Inspector-for-Debugging/) to get started. In the Web Inspector’s Console you can also see messages outputted with `console.log`. *Note, this only works on non-notarised versions of Phoenix (2.6.2 or later) or with debug builds.*
