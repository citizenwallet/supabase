-- CreateTable
CREATE TABLE "a_members" (
    "id" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "profile_contract" TEXT NOT NULL,
    "username" TEXT NOT NULL DEFAULT 'anonymous',
    "name" TEXT NOT NULL DEFAULT 'Anonymous',
    "description" TEXT NOT NULL DEFAULT 'this user does not have a profile',
    "image" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "image_medium" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "image_small" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "token_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "a_members_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "a_transfers" (
    "id" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "from_member_id" TEXT NOT NULL,
    "to_member_id" TEXT NOT NULL,
    "token_contract" TEXT NOT NULL,
    "value" TEXT NOT NULL DEFAULT '0',
    "description" TEXT NOT NULL DEFAULT '',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "a_transfers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "a_interactions" (
    "id" TEXT NOT NULL,
    "transfer_id" TEXT NOT NULL,
    "first_person_member_id" TEXT NOT NULL,
    "second_person_member_id" TEXT NOT NULL,
    "new_interaction" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "a_interactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "a_interactions_transfer_id_first_person_member_id_second_pe_key" ON "a_interactions"("transfer_id", "first_person_member_id", "second_person_member_id");

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
