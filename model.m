function model = model(t,y,parametry,czy)
if isempty(czy)
model = [(parametry(1)-parametry(2)*y(2))*y(1); (parametry(3)*y(1)-parametry(4))*y(2);];
%model drapieznik-ofiara Lotki-Volterry z kryjówkami dla ofiar%
elseif czy(2) < 0 %podawanie parametru "z" oznaczajacego schronienia dla ofiar%
model = [(parametry(1)*y(1)-(parametry(2)*(y(1)-czy(1))*y(2))); (parametry(3)*((y(1)-czy(1)))*y(2)-parametry(4)*y(2));];
%model drapieznik-ofiara Lotki-Volterry z ograniczona pojemnoscia srodowiska%
elseif czy(1) < 0 % podawanie parametru "K" oznaczajaca pojemnosc srodowiska%
model = [(parametry(1)*y(1)*(1-(y(1)/czy(2)))-parametry(2)*y(1)*y(2)); (parametry(3)*y(1)*y(2)-parametry(4)*y(2));]
else
disp('Nieprawid³owe parametry');
end
end