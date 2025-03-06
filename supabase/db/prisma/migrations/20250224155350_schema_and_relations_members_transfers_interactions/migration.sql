-- CreateTable
CREATE TABLE "a_members" (
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

    CONSTRAINT "a_members_pkey" PRIMARY KEY ("account")
);

-- CreateTable
CREATE TABLE "a_transfers" (
    "id" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "from_account" TEXT NOT NULL,
    "to_account" TEXT NOT NULL,
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
    "account" TEXT NOT NULL,
    "with" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "a_interactions_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_from_account_fkey" FOREIGN KEY ("from_account") REFERENCES "a_members"("account") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_to_account_fkey" FOREIGN KEY ("to_account") REFERENCES "a_members"("account") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_transfer_id_fkey" FOREIGN KEY ("transfer_id") REFERENCES "a_transfers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_account_fkey" FOREIGN KEY ("account") REFERENCES "a_members"("account") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_with_fkey" FOREIGN KEY ("with") REFERENCES "a_members"("account") ON DELETE RESTRICT ON UPDATE CASCADE;
