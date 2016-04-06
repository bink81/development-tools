select a.scope_id, count(1) 
    from ACTIVITY a 
  group by a.scope_id 
having count(1) > 1 
  order by a.scope_id;