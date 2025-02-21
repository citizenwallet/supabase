-- CreateEnum
CREATE TYPE "TransferStatus" AS ENUM ('pending', 'sending', 'success');

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
    "status" "TransferStatus" NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "a_transfers_pkey" PRIMARY KEY ("id")
);

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

-- CreateIndex
CREATE INDEX "a_members_account_idx" ON "a_members"("account");

-- CreateIndex
CREATE INDEX "a_members_contract_idx" ON "a_members"("contract");

-- CreateIndex
CREATE INDEX "a_members_account_contract_idx" ON "a_members"("account", "contract");

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_from_account_from_contract_fkey" FOREIGN KEY ("from_account", "from_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_transfers" ADD CONSTRAINT "a_transfers_to_account_to_contract_fkey" FOREIGN KEY ("to_account", "to_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;
