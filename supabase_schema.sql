-- Supabase Database Schema for TCloset App
-- Run this SQL in your Supabase SQL Editor

-- Enable Row Level Security (RLS) for all tables
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create clothing_items table
CREATE TABLE clothing_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    image_path TEXT NOT NULL,
    category TEXT NOT NULL,
    date_added TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create outfit_sets table
CREATE TABLE outfit_sets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    name TEXT NOT NULL,
    item_ids TEXT[] NOT NULL DEFAULT '{}',
    date_created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    notes TEXT,
    tags TEXT[] DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create collections table
CREATE TABLE collections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    item_ids TEXT[] NOT NULL DEFAULT '{}',
    outfit_ids TEXT[] NOT NULL DEFAULT '{}',
    date_created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_clothing_items_user_id ON clothing_items(user_id);
CREATE INDEX idx_clothing_items_category ON clothing_items(category);
CREATE INDEX idx_clothing_items_date_added ON clothing_items(date_added);

CREATE INDEX idx_outfit_sets_user_id ON outfit_sets(user_id);
CREATE INDEX idx_outfit_sets_date_created ON outfit_sets(date_created);

CREATE INDEX idx_collections_user_id ON collections(user_id);
CREATE INDEX idx_collections_date_created ON collections(date_created);

-- Enable Row Level Security (RLS)
ALTER TABLE clothing_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE outfit_sets ENABLE ROW LEVEL SECURITY;
ALTER TABLE collections ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for clothing_items
CREATE POLICY "Users can only see their own clothing items"
    ON clothing_items FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can only insert their own clothing items"
    ON clothing_items FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can only update their own clothing items"
    ON clothing_items FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can only delete their own clothing items"
    ON clothing_items FOR DELETE
    USING (auth.uid() = user_id);

-- Create RLS policies for outfit_sets
CREATE POLICY "Users can only see their own outfits"
    ON outfit_sets FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can only insert their own outfits"
    ON outfit_sets FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can only update their own outfits"
    ON outfit_sets FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can only delete their own outfits"
    ON outfit_sets FOR DELETE
    USING (auth.uid() = user_id);

-- Create RLS policies for collections
CREATE POLICY "Users can only see their own collections"
    ON collections FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can only insert their own collections"
    ON collections FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can only update their own collections"
    ON collections FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can only delete their own collections"
    ON collections FOR DELETE
    USING (auth.uid() = user_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_clothing_items_updated_at BEFORE UPDATE ON clothing_items
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_outfit_sets_updated_at BEFORE UPDATE ON outfit_sets
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_collections_updated_at BEFORE UPDATE ON collections
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
