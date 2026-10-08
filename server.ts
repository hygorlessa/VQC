import express from 'express';
import path from 'path';
import dotenv from 'dotenv';
import { EventEmitter } from 'events';
import apiRouter from './server/routes/api';

dotenv.config();
EventEmitter.defaultMaxListeners = 50;

const PORT = parseInt(process.env.PORT || '3000', 10);
const isProd = process.env.NODE_ENV === 'production';

export async function createApp() {
  const app = express();
  app.disable('x-powered-by');

  app.use((_req, res, next) => {
    res.setHeader('X-Content-Type-Options', 'nosniff');
    res.setHeader('X-Frame-Options', 'DENY');
    res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
    next();
  });

  app.use(express.json({ limit: '10mb' }));
  app.use(express.urlencoded({ extended: true, limit: '10mb' }));

  // Mount API router
  app.use('/api', apiRouter);

  if (!isProd && process.env.NODE_ENV !== 'test') {
    // Development mode with Vite middleware
    const { createServer } = await import('vite');
    const vite = await createServer({
      server: { middlewareMode: true },
      appType: 'spa'
    });
    app.use(vite.middlewares);
  } else if (isProd) {
    // Production static serving
    const distPath = path.resolve('dist');
    app.use(express.static(distPath));
    app.get('*', (_req, res) => {
      res.sendFile(path.resolve(distPath, 'index.html'));
    });
  }

  return app;
}

if (process.env.NODE_ENV !== 'test') {
  createApp()
    .then((app) => {
      app.listen(PORT, '0.0.0.0', () => {
        console.log(`[VQC Server] Running at http://0.0.0.0:${PORT}`);
      });
    })
    .catch((err) => {
      console.error('[VQC Server Error]', err);
      process.exit(1);
    });
}
