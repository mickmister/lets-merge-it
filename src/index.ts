import { Hono } from 'hono'
import { serve } from '@hono/node-server'

const app = new Hono()

// Basic routes
app.get('/', (c) => {
  const folder = c.req.query('folder') || '/Users/mickmister/code'

  return c.html(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Let's Merge It - Code Editor</title>
      <style>
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        body, html {
          height: 100%;
          overflow: hidden;
        }
        iframe {
          width: 100%;
          height: 100vh;
          border: none;
        }
      </style>
    </head>
    <body>
      <iframe src="/?folder=${encodeURIComponent(folder)}" title="Code Editor"></iframe>
    </body>
    </html>
  `)
})

app.get('/health', (c) => {
  return c.json({
    status: 'ok',
    timestamp: new Date().toISOString()
  })
})

app.get('/api/hello/:name', (c) => {
  const name = c.req.param('name')
  return c.json({
    message: `Hello, ${name}!`
  })
})

// 404 handler
app.notFound((c) => {
  return c.json({
    error: 'Not Found',
    path: c.req.path
  }, 404)
})

// Start server
const port = parseInt(process.env.PORT || '1340')

serve({
  fetch: app.fetch,
  port,
})

console.log(`Server is running on port ${port}`)
