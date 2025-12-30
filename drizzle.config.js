import { defineConfig } from "drizzle-kit";

export default defineConfig({
  dialect: "postgresql",
  schema: "./configs/schema.js",
  dbCredentials: {
    url: process.env.DATABASE_URL || "postgresql://ai_lms_user:ai_lms_password@localhost:5432/ai_lms",
  },
});
