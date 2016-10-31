p "Clearing out existing data..."
Player.delete_all
Table.delete_all

p "Seeding the database..."
t1 = Table.create
t2 = Table.create

p1 = Player.create(table: t1)
p2 = Player.create(table: t2)

t1.deal
t2.deal

p "...done!"
