-- Create the updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for each table
CREATE TRIGGER update_a_members_updated_at
    BEFORE UPDATE ON a_members
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_a_transfers_updated_at
    BEFORE UPDATE ON a_transfers
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_a_interactions_updated_at
    BEFORE UPDATE ON a_interactions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();