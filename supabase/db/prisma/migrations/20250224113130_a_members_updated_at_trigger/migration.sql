-- AlterTable
ALTER TABLE "a_members" ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP;

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_a_members_updated_at
    BEFORE UPDATE ON a_members
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();