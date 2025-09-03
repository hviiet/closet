# Supabase Setup Guide for TCloset App

## 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new account
2. Create a new project
3. Wait for the project to be fully initialized

## 2. Set Up Authentication

### Enable Google OAuth

1. Go to Authentication → Providers in your Supabase dashboard
2. Find Google and click "Enable"
3. You'll need to create OAuth credentials in Google Cloud Console:

   a. Go to [Google Cloud Console](https://console.cloud.google.com/)
   b. Create a new project or select existing one
   c. Enable Google+ API
   d. Go to "Credentials" → "Create Credentials" → "OAuth 2.0 Client IDs"
   e. Set Application type to "Web application"
   f. Add authorized redirect URIs:
      - `https://your-project-id.supabase.co/auth/v1/callback`
   g. Copy the Client ID and Client Secret

4. Back in Supabase, enter:
   - Client ID: Your Google OAuth Client ID
   - Client Secret: Your Google OAuth Client Secret
   - Enable "Skip nonce check" (important for mobile apps)

## 3. Database Setup

### Run the Schema Migration

1. Go to SQL Editor in your Supabase dashboard
2. Copy and paste the contents of `supabase_schema.sql`
3. Run the SQL script

This will create:
- `clothing_items` table
- `outfit_sets` table
- `collections` table
- Row Level Security (RLS) policies
- Indexes for performance
- Triggers for auto-updating timestamps

## 4. Environment Configuration

### Update your `.env` file:

```env
# Supabase Configuration
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-supabase-anon-key

# Image Upload Services
IMG_BB_KEY=your_imgbb_api_key
```

### Get Supabase Keys

1. Go to Settings → API in your Supabase dashboard
2. Copy the "Project URL" and "anon public" key
3. Update your `.env` file with these values

## 5. Google Sign-In Setup for Mobile

### Android Setup

1. In your Google Cloud Console, create OAuth credentials for Android:
   - Application type: Android
   - Package name: `com.example.tcloset` (or your app's package name)
   - SHA-1 certificate fingerprint: Get from your Android keystore

2. Add the Android Client ID to your Supabase Google OAuth configuration

### iOS Setup (if needed)

1. In Google Cloud Console, create OAuth credentials for iOS:
   - Application type: iOS
   - Bundle ID: Your iOS app bundle ID
   - App Store ID: (optional)

2. Add the iOS Client ID to your Supabase Google OAuth configuration

## 6. Testing the Setup

1. Run your Flutter app
2. Try signing in with Google
3. Add some clothing items
4. Create outfits and collections
5. Verify data is being saved to Supabase

## 7. Supabase Dashboard Features

### Monitor Your Data
- Go to Table Editor to see your data
- Check Authentication → Users to see registered users
- Monitor API usage in Reports

### Real-time Features
The app is set up to work with Supabase's real-time features. You can enable real-time subscriptions for live updates across devices.

## Troubleshooting

### Common Issues:

1. **"Auth provider not configured"**
   - Make sure Google OAuth is enabled in Supabase
   - Check that your Google Cloud credentials are correct

2. **"RLS policy violation"**
   - Make sure the SQL schema was run correctly
   - Check that RLS policies are enabled

3. **"Invalid API key"**
   - Verify your `.env` file has the correct Supabase URL and anon key

4. **Images not uploading**
   - Check your ImgBB API key
   - Verify internet permission in Android manifest

### Useful Supabase Commands:

```sql
-- Check if tables exist
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';

-- Check RLS policies
SELECT * FROM pg_policies WHERE schemaname = 'public';

-- View recent auth users
SELECT * FROM auth.users ORDER BY created_at DESC LIMIT 10;
```

## Security Notes

- The RLS policies ensure users can only access their own data
- Never commit your `.env` file to version control
- Keep your Supabase service role key secure (only for server-side operations)
- Regularly update your dependencies for security patches
