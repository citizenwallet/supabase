-- CreateTable
CREATE TABLE "a_members" (
    "account" TEXT NOT NULL,
    "contract" TEXT NOT NULL,
    "username" TEXT NOT NULL DEFAULT 'anonymous',
    "name" TEXT NOT NULL DEFAULT 'Anonymous',
    "description" TEXT NOT NULL DEFAULT 'this user does not have a profile',
    "image" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "image_medium" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "image_small" TEXT NOT NULL DEFAULT 'https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh',
    "token_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "a_members_pkey" PRIMARY KEY ("account","contract")
);

-- CreateTable
CREATE TABLE "a_transfers" (
    "id" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "from_account" TEXT NOT NULL,
    "from_contract" TEXT NOT NULL,
    "to_account" TEXT NOT NULL,
    "to_contract" TEXT NOT NULL,
    "value" TEXT NOT NULL DEFAULT '0',
    "description" TEXT NOT NULL DEFAULT '',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "a_transfers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "a_interactions" (
    "id" TEXT NOT NULL,
    "transfer_id" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "account_contract" TEXT NOT NULL,
    "with" TEXT NOT NULL,
    "with_contract" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "a_interactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "a_members_account_idx" ON "a_members"("account");

-- CreateIndex
CREATE INDEX "a_members_contract_idx" ON "a_members"("contract");

-- CreateIndex
CREATE INDEX "a_members_account_contract_idx" ON "a_members"("account", "contract");

-- CreateIndex
CREATE INDEX "a_transfers_from_account_idx" ON "a_transfers"("from_account");

-- CreateIndex
CREATE INDEX "a_transfers_from_contract_idx" ON "a_transfers"("from_contract");

-- CreateIndex
CREATE INDEX "a_transfers_to_account_idx" ON "a_transfers"("to_account");

-- CreateIndex
CREATE INDEX "a_transfers_to_contract_idx" ON "a_transfers"("to_contract");

-- CreateIndex
CREATE INDEX "a_transfers_from_account_from_contract_idx" ON "a_transfers"("from_account", "from_contract");

-- CreateIndex
CREATE INDEX "a_transfers_to_account_to_contract_idx" ON "a_transfers"("to_account", "to_contract");

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_from_account_from_contract_fkey" FOREIGN KEY ("from_account", "from_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_to_account_to_contract_fkey" FOREIGN KEY ("to_account", "to_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_transfer_id_fkey" FOREIGN KEY ("transfer_id") REFERENCES "a_transfers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_account_account_contract_fkey" FOREIGN KEY ("account", "account_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_with_with_contract_fkey" FOREIGN KEY ("with", "with_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;
