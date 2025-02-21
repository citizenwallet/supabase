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

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_transfer_id_fkey" FOREIGN KEY ("transfer_id") REFERENCES "a_transfers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_account_account_contract_fkey" FOREIGN KEY ("account", "account_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "a_interactions" ADD CONSTRAINT "a_interactions_with_with_contract_fkey" FOREIGN KEY ("with", "with_contract") REFERENCES "a_members"("account", "contract") ON DELETE RESTRICT ON UPDATE CASCADE;
