/*
  Warnings:

  - You are about to drop the column `account_contract` on the `a_interactions` table. All the data in the column will be lost.
  - You are about to drop the column `with_contract` on the `a_interactions` table. All the data in the column will be lost.
  - The primary key for the `a_members` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `account_contract` to the `a_members` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "a_interactions" DROP CONSTRAINT "a_interactions_account_account_contract_fkey";

-- DropForeignKey
ALTER TABLE "a_interactions" DROP CONSTRAINT "a_interactions_with_with_contract_fkey";

-- DropForeignKey
ALTER TABLE "a_transfers" DROP CONSTRAINT "a_transfers_from_account_from_contract_fkey";

-- DropForeignKey
ALTER TABLE "a_transfers" DROP CONSTRAINT "a_transfers_to_account_to_contract_fkey";

-- AlterTable
ALTER TABLE "a_interactions" DROP COLUMN "account_contract",
DROP COLUMN "with_contract";

-- AlterTable
ALTER TABLE "a_members" DROP CONSTRAINT "a_members_pkey",
ADD COLUMN     "account_contract" TEXT NOT NULL,
ADD CONSTRAINT "a_members_pkey" PRIMARY KEY ("account_contract");

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_from_account_fkey" FOREIGN KEY ("from_account") REFERENCES "a_members"("account_contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_to_account_fkey" FOREIGN KEY ("to_account") REFERENCES "a_members"("account_contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_account_fkey" FOREIGN KEY ("account") REFERENCES "a_members"("account_contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_with_fkey" FOREIGN KEY ("with") REFERENCES "a_members"("account_contract") ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE OR REPLACE FUNCTION generate_member_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.account_contract = NEW.account || ':' || NEW.contract;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER assign_member_id
    BEFORE INSERT OR UPDATE ON a_members
    FOR EACH ROW
    EXECUTE FUNCTION generate_member_id();