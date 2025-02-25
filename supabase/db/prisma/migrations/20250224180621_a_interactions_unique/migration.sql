/*
  Warnings:

  - A unique constraint covering the columns `[transfer_id,first_person_member_id,second_person_member_id]` on the table `a_interactions` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "a_interactions_transfer_id_first_person_member_id_second_pe_key" ON "a_interactions"("transfer_id", "first_person_member_id", "second_person_member_id");
