export const runtime = "nodejs"; // 🔴 REQUIRED (pg does NOT work on Edge)

import { NextResponse } from "next/server";
import { getDb } from "@/lib/db";
import { users } from "@/configs/schema";
import { eq } from "drizzle-orm";
import bcrypt from "bcryptjs";

export async function POST(req) {
  try {
    const body = await req.json();
    const { email, password } = body;

    const db = getDb(); // ✅ Initialize DB correctly

    const result = await db
      .select()
      .from(users)
      .where(eq(users.email, email));

    if (result.length === 0) {
      return NextResponse.json(
        { error: "Invalid credentials" },
        { status: 401 }
      );
    }

    const user = result[0];
    const isValid = await bcrypt.compare(password, user.password);

    if (!isValid) {
      return NextResponse.json(
        { error: "Invalid credentials" },
        { status: 401 }
      );
    }

    return NextResponse.json({
      success: true,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
      },
    });
  } catch (err) {
    console.error("Login error:", err);
    return NextResponse.json(
      { error: "Login failed" },
      { status: 500 }
    );
  }
}
