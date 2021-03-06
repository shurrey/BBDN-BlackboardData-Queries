select
    lei.name,
    count(distinct lei.course_id) as courses_where_aligned,
    count(distinct lpc.course_id) as courses_where_used,
    count(distinct lpc.person_id) as students_assessed,
    count(distinct le.id) as grade_count
from cdm_lms.evaluable_item lei
left join cdm_lms.evaluation le
    on le.evaluable_item_id = lei.id
left join cdm_lms.evaluable_course_item leci
    on leci.id = le.evaluable_course_item_id
inner join cdm_lms.course lc
    on lc.id = lei.course_id
left join cdm_lms.term lt
    on lt.id = lc.term_id
left join cdm_lms.person_course lpc
    on lpc.id = le.person_course_id
    and lpc.course_id = lc.id
where /* --UNCOMMENT TO FILTER BY TERM AND/OR START DATE
    (
    lt.name = 'Fall 2018'
    or (
        lc.start_date > '2018-08-31'
        and lc.start_date < '2018-12-31'
      )
    )
and */
lei.type = 'RUBRIC_CRITERIA'
group by lei.name