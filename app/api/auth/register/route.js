export const runtime = "nodejs"; // 🔴 REQUIRED (pg does NOT work on Edge)

import { NextResponse } from "next/server";
import { getDb } from "@/lib/db";
import { users } from "@/configs/schema";
import { eq } from "drizzle-orm";
import bcrypt from "bcryptjs";

export async function POST(req) {
  try {
    const body = await req.json();
    const { name, email, password } = body;

    const db = getDb(); // ✅ Initialize DB correctly

    const existing = await db
      .select()
      .from(users)
      .where(eq(users.email, email));

    if (existing.length > 0) {
      return NextResponse.json(
        { error: "User already exists" },
        { status: 400 }
      );
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    await db.insert(users).values({
      name,
      email,
      password: hashedPassword,
    });

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error("Register error:", err);
    return NextResponse.json(
      { error: "Failed to register user" },
      { status: 500 }
    );
  }
}
