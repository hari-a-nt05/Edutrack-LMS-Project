<<<<<<< HEAD
import "server-only";

import { drizzle } from "drizzle-orm/node-postgres";
import pkg from "pg";

const { Pool } = pkg;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export const db = drizzle(pool);
=======
import { neon } from "@neondatabase/serverless";
import { drizzle } from "drizzle-orm/neon-http";

const connectionString = process.env.NEXT_PUBLIC_DATABASE_CONNECTION_STRING || "postgresql://ai_lms_user:ai_lms_password@localhost:5432/ai_lms";

const sql = neon(connectionString);
export const db = drizzle(sql);

>>>>>>> 1669b30742863133c51b1c572e4f0de50930b312
