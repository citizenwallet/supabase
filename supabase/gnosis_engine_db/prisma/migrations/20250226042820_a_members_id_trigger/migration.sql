CREATE OR REPLACE FUNCTION generate_member_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.id = NEW.account || ':' || NEW.profile_contract;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER assign_member_id
    BEFORE INSERT OR UPDATE ON a_members
    FOR EACH ROW
    EXECUTE FUNCTION generate_member_id();
