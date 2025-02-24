-- AlterTable
ALTER TABLE "a_interactions" ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP;

-- Reuse the existing function if it exists, otherwise it will be created
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create new trigger for a_interactions
CREATE TRIGGER update_a_interactions_updated_at
    BEFORE UPDATE ON a_interactions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();