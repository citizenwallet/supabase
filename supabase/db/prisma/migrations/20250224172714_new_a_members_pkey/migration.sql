/*
  Warnings:

  - You are about to drop the column `account` on the `a_interactions` table. All the data in the column will be lost.
  - You are about to drop the column `with` on the `a_interactions` table. All the data in the column will be lost.
  - The primary key for the `a_members` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `from_account` on the `a_transfers` table. All the data in the column will be lost.
  - You are about to drop the column `to_account` on the `a_transfers` table. All the data in the column will be lost.
  - Added the required column `first_person_member_id` to the `a_interactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `second_person_member_id` to the `a_interactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `a_members` table without a default value. This is not possible if the table is not empty.
  - Added the required column `from_member_id` to the `a_transfers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `to_member_id` to the `a_transfers` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "a_interactions" DROP CONSTRAINT "a_interactions_account_fkey";

-- DropForeignKey
ALTER TABLE "a_interactions" DROP CONSTRAINT "a_interactions_transfer_id_fkey";

-- DropForeignKey
ALTER TABLE "a_interactions" DROP CONSTRAINT "a_interactions_with_fkey";

-- DropForeignKey
ALTER TABLE "a_transfers" DROP CONSTRAINT "a_transfers_from_account_fkey";

-- DropForeignKey
ALTER TABLE "a_transfers" DROP CONSTRAINT "a_transfers_to_account_fkey";

-- AlterTable
ALTER TABLE "a_interactions" DROP COLUMN "account",
DROP COLUMN "with",
ADD COLUMN     "first_person_member_id" TEXT NOT NULL,
ADD COLUMN     "second_person_member_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "a_members" DROP CONSTRAINT "a_members_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "a_members_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "a_transfers" DROP COLUMN "from_account",
DROP COLUMN "to_account",
ADD COLUMN     "from_member_id" TEXT NOT NULL,
ADD COLUMN     "to_member_id" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_from_member_id_fkey" FOREIGN KEY ("from_member_id") REFERENCES "a_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_to_member_id_fkey" FOREIGN KEY ("to_member_id") REFERENCES "a_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_transfer_id_fkey" FOREIGN KEY ("transfer_id") REFERENCES "a_transfers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_first_person_member_id_fkey" FOREIGN KEY ("first_person_member_id") REFERENCES "a_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_second_person_member_id_fkey" FOREIGN KEY ("second_person_member_id") REFERENCES "a_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;
