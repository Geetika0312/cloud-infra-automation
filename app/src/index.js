const express = require("express");
const os = require("os");

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;
const VERSION = process.env.APP_VERSION || "dev";

// In-memory only - the point of this app is to demonstrate the platform
// (containers, scaling, rolling updates), not to be a real data store.
let tasks = [
  { id: 1, title: "Provision AKS with Terraform", done: true },
  { id: 2, title: "Containerize the API", done: true },
  { id: 3, title: "Deploy to Kubernetes", done: false },
];
let nextId = 4;

// Liveness: is the process alive at all.
app.get("/healthz", (_req, res) => {
  res.status(200).json({ status: "ok" });
});

// Readiness: is this pod ready to receive traffic.
app.get("/readyz", (_req, res) => {
  res.status(200).json({ status: "ready" });
});

// Returns which pod answered - makes it obvious in a demo that traffic is
// being load-balanced across replicas, and which version is running during
// a rolling update.
app.get("/", (_req, res) => {
  res.json({
    message: "cloud-infra-demo-api",
    version: VERSION,
    pod: os.hostname(),
  });
});

app.get("/api/tasks", (_req, res) => {
  res.json(tasks);
});

app.post("/api/tasks", (req, res) => {
  const { title } = req.body || {};
  if (!title || typeof title !== "string") {
    return res.status(400).json({ error: "title (string) is required" });
  }
  const task = { id: nextId++, title, done: false };
  tasks.push(task);
  res.status(201).json(task);
});

const server = app.listen(PORT, () => {
  console.log(`listening on :${PORT} (version=${VERSION}, pod=${os.hostname()})`);
});

// Kubernetes sends SIGTERM before killing a pod during a rolling update or
// scale-down. Without this, in-flight requests get dropped instead of
// finishing cleanly.
process.on("SIGTERM", () => {
  console.log("SIGTERM received, shutting down gracefully");
  server.close(() => process.exit(0));
});
