if School.count == 0
  School.create!([
    {name: "Sunshine Kindergarten"}
  ])
end
schools = School.all

if User.count == 0
  User.create!([
    {email: "test@test.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, school_id: schools[0].id, name: nil, pin: "1111", classroom: "ม. 1/1"},
    {email: "admin@bananacoding.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2016-12-26 07:33:11", last_sign_in_at: "2016-12-26 07:28:33", current_sign_in_ip: "180.183.204.78", last_sign_in_ip: "180.183.204.78", school_id: schools[0].id, name: nil, pin: "2222", classroom: "ม. 1/2"},
    {email: "manit@bananacoding.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2016-12-26 10:25:26", last_sign_in_at: "2016-12-26 08:19:32", current_sign_in_ip: "::1", last_sign_in_ip: "58.11.94.19", school_id: schools[0].id, name: nil, pin: "3333", classroom: "ม. 1/3"},
    {email: "putamthong@gmail.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2016-12-27 02:20:42", last_sign_in_at: "2016-12-27 02:20:42", current_sign_in_ip: "::1", last_sign_in_ip: "::1", school_id: schools[0].id, name: nil, pin: "4444", classroom: "ม. 2/1"},
    {email: "admin@sunshinekindergarten.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, school_id: schools[0].id, name: nil, pin: "5555"}
  ])
end
users = User.all

if Employee.count == 0
  Employee.create!([
    {school_id: schools[0].id, first_name: "Christine", last_name: "Pronske", middle_name: "Michelle", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-08688-37-3", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Christine", start_date: "2016-10-31 08:48:03"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-9098-00264-76-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ปรารถนา", last_name_thai: "วารีดำ", prefix_thai: "นางสาว", nickname: "Shaylene", start_date: "2014-05-25 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5602-00071-31-2", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "พรศิรินทร์", last_name_thai: "กล้วยไม้ ณ อยุธยา", prefix_thai: "นางสาว", nickname: "ปูเป้", start_date: "2016-10-30 17:00:00"},
    {school_id: schools[0].id, first_name: "Patra", last_name: "Capelli", middle_name: "", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "1-1002-00225-01-1", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "", last_name_thai: "", prefix_thai: "", nickname: "Patty", start_date: "2015-05-17 17:00:00"},
    {school_id: schools[0].id, first_name: "Philip", last_name: "Keidaish III", middle_name: "Frederic", prefix: "Mr", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-11480-13-3", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Philip", start_date: "2016-05-09 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-5099-00391-90-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ทิตยา", last_name_thai: "เป็งธรรม", prefix_thai: "นางสาว", nickname: "ฟาง", start_date: "2011-08-14 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "3-5002-00917-77-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "รำพรรณ", last_name_thai: "วังทอง", prefix_thai: "นาง", nickname: "อ้อย", start_date: "2013-03-31 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-6405-00056-74-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ผกามาศ", last_name_thai: "ตระกูลอินทร์", prefix_thai: "นางสาว", nickname: "กา", start_date: "2013-10-08 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-6406-00014-93-5", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ดนุดา", last_name_thai: "ยนต์นิยม", prefix_thai: "นางสาว", nickname: "นุ๊ก", start_date: "2013-10-31 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-8607-00010-01-8", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ธนพร", last_name_thai: "โชติพรหมราช", prefix_thai: "นางสาว", nickname: "อ้อย", start_date: "2015-04-10 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "3-1005-03132-56-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ปภัศสา", last_name_thai: "ปทุมวัฒน์", prefix_thai: "นางสาว", nickname: "ทราย", start_date: "2015-10-18 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-5099-00299-82-9", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "หนึ่งฤทัย", last_name_thai: "ไชยจินดา", prefix_thai: nil, nickname: "เมย์", start_date: "2016-08-03 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-5099-00279-95-0", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อัมภวรรณ", last_name_thai: "ปินตา", prefix_thai: "นางสาว", nickname: "ออฟ", start_date: "2016-10-09 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5599-00176-56-5", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ศิริลักษณ์", last_name_thai: "ขันแก้ว", prefix_thai: "นางสาว", nickname: "นิก", start_date: "2015-10-18 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5012-00078-43-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อาทิตยา", last_name_thai: "วงค์แสน", prefix_thai: "นางสาว", nickname: "น้ำหวาน", start_date: "2015-10-18 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5099-00165-81-4", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ภรณ์ทิพย์", last_name_thai: "จันทร์ดี", prefix_thai: "นางสาว", nickname: "ก้อย", start_date: "2015-10-31 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5099-00520-79-7", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "กมลพรรณ", last_name_thai: "ทาทอง", prefix_thai: "นาง", nickname: "นิต", start_date: "2015-11-01 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-6304-00040-72-0", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อรนุช", last_name_thai: "ทับศรีรักษ์", prefix_thai: "นางสาว", nickname: "แอร์", start_date: "2015-12-13 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5007-00116-22-6", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อลิสรา", last_name_thai: "ทองชิว", prefix_thai: "นางสาว", nickname: "แอลลี่", start_date: "2016-10-09 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5599-00196-49-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ศิริพร", last_name_thai: "พรหมโชติ", prefix_thai: "นางสาว", nickname: "เจ", start_date: "2016-10-30 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูพี่เลี้ยง", personal_id: "1-5018-00053-91-0", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อัมรา", last_name_thai: "บุญปัน", prefix_thai: "นางสาว", nickname: "เหมียว", start_date: "2016-04-17 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูพี่เลี้ยง", personal_id: "1-5099-00922-00-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อังคณา", last_name_thai: "ยาสมุทร", prefix_thai: "นางสาว", nickname: "เนส", start_date: "2016-06-22 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูวิชาการ", personal_id: "3-7403-00343-54-8", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "สรญา", last_name_thai: "ออลมาร์ก เพื่อ ด.ช. สรัชชพงศ์ เชี่ยวสุทธิ", prefix_thai: "นาง", nickname: "มด", start_date: "2016-06-22 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ธุรการ", personal_id: "1-5099-00715-54-7", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "พัชราภรณ์", last_name_thai: "คำแก้ว", prefix_thai: "นางสาว", nickname: "มิ้นท์", start_date: "2016-11-10 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "บัญชีการเงิน", personal_id: "3-1014-01790-69-4", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "สุภาพร", last_name_thai: "แต้มทอง", prefix_thai: "นางสาว", nickname: "ปู", start_date: "2016-01-08 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "การตลาด", personal_id: "1-5099-00216-42-7", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ณัฐรดี", last_name_thai: "เกี๋ยงเหมย", prefix_thai: "นางสาว", nickname: "แอม", start_date: "2016-07-31 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-6001-00221-12-5", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "30000.0", img_url: "", first_name_thai: "ชนินทร", last_name_thai: "ศรีป้อม", prefix_thai: "นางสาว", nickname: "ดิว", start_date: "2011-08-14 17:00:00"},
    {school_id: schools[0].id, first_name: "Eliane", last_name: "Mortreux", middle_name: "", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-11479-98-4", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "35000.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Elly", start_date: "2015-06-07 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ผู้อำนวยการโรงเรียน", personal_id: "3-5190-00042-61-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "รัชนีบูลย์", last_name_thai: "เกริกไกวัล", prefix_thai: "นาง", nickname: "คุณแม่", start_date: "2014-07-15 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "แม่ครัว", personal_id: "3-6009-00570-03-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "จันทร์ฉาย", last_name_thai: "บัวย้อย", prefix_thai: "นาง", nickname: "ป้าจันทร์", start_date: "2012-08-20 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "แม่บ้าน", personal_id: "3-5001-00121-17-9", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ศรีพรรณ", last_name_thai: "คำหล้า", prefix_thai: "นาง", nickname: "ป้าพรรณ", start_date: "2014-05-31 17:00:00"},
    {school_id: schools[0].id, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "แม่บ้าน", personal_id: "3-5012-00772-28-8", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "พจนีย์", last_name_thai: "ศรีปา", prefix_thai: "นางสาว", nickname: "แวว", start_date: "2016-11-13 17:00:00"},
    {school_id: schools[0].id, first_name: "Sai  Bawga", last_name: "Bawga", middle_name: "", prefix: "Mr", sex: 0, position: "รปภ.", personal_id: "", passport_number: "00-5001-117655-5", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "กล้า", start_date: "2014-06-30 17:00:00"},
    {school_id: schools[0].id, first_name: "Nan  Hseng", last_name: "Mwam", middle_name: "", prefix: "Ms", sex: 0, position: "แม่บ้าน", personal_id: "", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "", last_name_thai: nil, prefix_thai: nil, nickname: "หนิง", start_date: "2015-05-18 17:00:00"},
    {school_id: schools[0].id, first_name: "Samantha", last_name: "Loyd", middle_name: "Natasha", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-09778-98-8", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Sammy", start_date: nil}
  ])
end

if Payroll.count == 0
date_now = DateTime.now
  employees = Employee.all
  Payroll.create!({employee: employees[0], salary: "34000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "2000.0", social_insurance: "750.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[1], salary: "25500.0", allowance: "0.0", attendance_bonus: "0.0", ot: "2000.0", bonus: "0.0", position_allowance: "1000.0", extra_etc: "10000.0", absence: "0.0", late: "0.0", tax: "1300.0", social_insurance: "750.0", fee_etc: "20.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[2], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[3], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[4], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[5], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[6], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[7], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[8], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[9], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[10], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[11], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[12], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[13], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[14], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[15], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[16], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[17], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[18], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[19], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[20], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[21], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[22], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[23], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[24], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[25], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[26], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[27], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[28], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[29], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[30], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[31], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[32], salary: "35000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "1050.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[33], salary: "30000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "750.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[34], salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now})
  Payroll.create!({employee: employees[0], salary: "30000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "1000.0", pvf: "0.0", advance_payment: "0.0", effective_date: (date_now - 1.month).to_datetime})
  Payroll.create!({employee: employees[0], salary: "2000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: (date_now - 2.month).to_datetime})
end

if Taxrate.count == 0
  Taxrate.create!([
   {order_id: "1", income: "5000000", tax: "0.35"},
   {order_id: "2", income: "2000000", tax: "0.30"},
   {order_id: "3", income: "1000000", tax: "0.25"},
   {order_id: "4", income: "750000", tax: "0.20"},
   {order_id: "5", income: "500000", tax: "0.15"},
   {order_id: "6", income: "300000", tax: "0.10"},
   {order_id: "7", income: "150000", tax: "0.05"}
  ])
end

Employee.all.each do |employee|
  if TaxReduction.find_by(employee_id: employee.id)==nil
    TaxReduction.create!(employee_id: employee.id);
  end
end

TaxReduction.all.each do |tax|
    if tax.expenses == 0
        tax.expenses = 60000.0
        tax.save
    end
end

# invoice
AccountType.create([{ name: 'Income' }, { name: 'Expenses' }]) if AccountType.count == 0
Gender.create([{ name: 'Male'},{ name: 'Female'}]) if Gender.count == 0
Grade.create([{ name: 'Preschool' },{ name: 'Kindergarten 1' },{ name: 'Kindergarten 2' },{ name: 'Kindergarten 3' }]) if Grade.count == 0
Relationship.create([{ name: 'Father' }, { name: 'Mother' }, { name: 'Grandfather' }, { name: 'Grandmother' }, { name: 'Uncle' }, { name: 'Aunt' }, { name: 'Cousin' }]) if Relationship.count == 0
InvoiceStatus.create([{ name: 'Active' }, { name: 'Canceled' }]) if InvoiceStatus.count == 0

#roll calls
if Student.where(student_number: 2001..2040).count == 0 && Student.where(student_number: 1001..1040).count == 0
  school_a = schools[0]
  a11 = Student.create({ student_number: 1001, prefix: "ด.ช.", first_name: "ชญานนท์", last_name: "สมตุ้ย", school_id: school_a.id, classroom_number: 1 })
  a12 = Student.create({ student_number: 1002, prefix: "ด.ช.", first_name: "ธนพนธ์", last_name: "วงค์โรจนเมธี", school_id: school_a.id, classroom_number: 2 })
  a13 = Student.create({ student_number: 1003, prefix: "ด.ช.", first_name: "เอกชัย", last_name: "เชาวนางกูร", school_id: school_a.id, classroom_number: 3 })
  a14 = Student.create({ student_number: 1004, prefix: "ด.ญ.", first_name: "ยุพิน", last_name: "ศุภลักษณากร", school_id: school_a.id, classroom_number: 4 })
  a15 = Student.create({ student_number: 1005, prefix: "ด.ช.", first_name: "สุภาพ", last_name: "ดุเจโต๊ะ", school_id: school_a.id, classroom_number: 5 })
  a16 = Student.create({ student_number: 1006, prefix: "ด.ญ.", first_name: "วรรณิดา", last_name: "ใจคำ", school_id: school_a.id, classroom_number: 6 })
  a17 = Student.create({ student_number: 1007, prefix: "ด.ช.", first_name: "ธนภัทร", last_name: "อินตา", school_id: school_a.id, classroom_number: 7 })
  a18 = Student.create({ student_number: 1008, prefix: "ด.ช.", first_name: "นพธีรา", last_name: "ไฝคำ", school_id: school_a.id, classroom_number: 8 })
  a19 = Student.create({ student_number: 1009, prefix: "ด.ญ.", first_name: "แลง", last_name: "กู่งนะ", school_id: school_a.id, classroom_number: 9 })
  a20 = Student.create({ student_number: 1010, prefix: "ด.ช.", first_name: "สุรินทร์", last_name: "เตชะเลิศพนา", school_id: school_a.id, classroom_number: 10 })
  a21 = Student.create({ student_number: 1011, prefix: "ด.ช.", first_name: "ธนพนธ์", last_name: "เช็งยะ", school_id: school_a.id, classroom_number: 11 })
  a22 = Student.create({ student_number: 1012, prefix: "ด.ณ.", first_name: "อฐิษา", last_name: "ทาเรือง", school_id: school_a.id, classroom_number: 12 })
  a23 = Student.create({ student_number: 1013, prefix: "ด.ช.", first_name: "ทักษ์", last_name: "แช่เฮ้อ", school_id: school_a.id, classroom_number: 13 })
  a24 = Student.create({ student_number: 1014, prefix: "ด.ช.", first_name: "กนกพล", last_name: "มณีวรรณ", school_id: school_a.id, classroom_number: 14 })
  a25 = Student.create({ student_number: 1015, prefix: "ด.ช.", first_name: "ทุน", last_name: "ลุงช่วย", school_id: school_a.id, classroom_number: 15 })
  a26 = Student.create({ student_number: 1016, prefix: "ด.ช.", first_name: "ภัทรพล", last_name: "คนเที่ยง", school_id: school_a.id, classroom_number: 16 })
  a27 = Student.create({ student_number: 1017, prefix: "ด.ญ.", first_name: "สรัญญา", last_name: "นันท์ชัย", school_id: school_a.id, classroom_number: 17 })
  a28 = Student.create({ student_number: 1018, prefix: "ด.ช.", first_name: "ศุภกร", last_name: "คำฝัน", school_id: school_a.id, classroom_number: 18 })
  a29 = Student.create({ student_number: 1019, prefix: "ด.ช.", first_name: "หน่อเงิน", last_name: "ปันทะ", school_id: school_a.id, classroom_number: 19 })
  a30 = Student.create({ student_number: 1020, prefix: "ด.ช.", first_name: "เสรี", last_name: "สุธรพรมรักษ์", school_id: school_a.id, classroom_number: 20 })
  a31 = Student.create({ student_number: 1021, prefix: "ด.ญ.", first_name: "แสงรวี", last_name: "จรูญบุญทวี", school_id: school_a.id, classroom_number: 21 })
  a32 = Student.create({ student_number: 1022, prefix: "ด.ช.", first_name: "นพวรรณ", last_name: "จันทรยุทธ", school_id: school_a.id, classroom_number: 22 })
  a33 = Student.create({ student_number: 1023, prefix: "ด.ญ.", first_name: "ทัศนีย์", last_name: "รักษาวารีเลิศ", school_id: school_a.id, classroom_number: 23 })
  a34 = Student.create({ student_number: 1024, prefix: "ด.ญ.", first_name: "พรลิดา", last_name: "บรรจงวรฉัตร", school_id: school_a.id, classroom_number: 24 })
  a35 = Student.create({ student_number: 1025, prefix: "ด.ช.", first_name: "พีระศักดิ์", last_name: "ดำรงพรวารี", school_id: school_a.id, classroom_number: 25 })
  a36 = Student.create({ student_number: 1026, prefix: "ด.ญ.", first_name: "รัชฎา", last_name: "อร่ามเวชวิบูลย์", school_id: school_a.id, classroom_number: 26 })
  a37 = Student.create({ student_number: 1027, prefix: "ด.ญ.", first_name: "รุ่งทิตย์พร", last_name: "ชื่นสุขจำเริญกุล", school_id: school_a.id, classroom_number: 27 })
  a38 = Student.create({ student_number: 1028, prefix: "ด.ญ.", first_name: "อธิชา", last_name: "ดำรงเกียรติไพร", school_id: school_a.id, classroom_number: 28 })
  a39 = Student.create({ student_number: 1029, prefix: "ด.ช.", first_name: "อนุวัฒน์", last_name: "สุภาพวรพร", school_id: school_a.id, classroom_number: 29 })
  a40 = Student.create({ student_number: 1030, prefix: "ด.ช.", first_name: "อภิชาติ", last_name: "ดำรงพรวารี", school_id: school_a.id, classroom_number: 30 })
  a41 = Student.create({ student_number: 1031, prefix: "ด.ช.", first_name: "อัจฉวิน", last_name: "โชคชัยกูล", school_id: school_a.id, classroom_number: 31 })
  a42 = Student.create({ student_number: 1032, prefix: "ด.ญ.", first_name: "มัญชรี", last_name: "พวกทอง", school_id: school_a.id, classroom_number: 32 })
  a43 = Student.create({ student_number: 1033, prefix: "ด.ญ.", first_name: "ธัญชนก", last_name: "กันทาใจ", school_id: school_a.id, classroom_number: 33 })
  a44 = Student.create({ student_number: 1034, prefix: "ด.ช.", first_name: "ณัทดนัย", last_name: "สุวรรณ์", school_id: school_a.id, classroom_number: 34 })
  a45 = Student.create({ student_number: 1035, prefix: "ด.ช.", first_name: "ถิรพุทธิ์", last_name: "แซ่ยะ", school_id: school_a.id, classroom_number: 35 })
  a46 = Student.create({ student_number: 1036, prefix: "ด.ช.", first_name: "นธรชัย", last_name: "สุธรพรมรักษ์", school_id: school_a.id, classroom_number: 36 })
  a47 = Student.create({ student_number: 1037, prefix: "ด.ญ.", first_name: "เจือจันทรฺ", last_name: "พิลาสชวนพิศ", school_id: school_a.id, classroom_number: 37 })
  a48 = Student.create({ student_number: 1038, prefix: "ด.ญ.", first_name: "ฐิติมา", last_name: "พิลาสชวนพิศ", school_id: school_a.id, classroom_number: 38 })
  a49 = Student.create({ student_number: 1039, prefix: "ด.ญ.", first_name: "เสาวลักษณ์", last_name: "วิมุตวโรตม์", school_id: school_a.id, classroom_number: 39 })
  a50 = Student.create({ student_number: 1040, prefix: "ด.ช.", first_name: "ศักดา", last_name: "ชีวีนิธีสกุล", school_id: school_a.id, classroom_number: 40 })

  b11 = Student.create({ student_number: 2001, prefix: "ด.ช.", first_name: "บุญญฤทธิ์", last_name: "ปัญญานนท์", school_id: school_a.id, number: 1 })
  b12 = Student.create({ student_number: 2002, prefix: "ด.ญ.", first_name: "กรรณิการ์", last_name: "ธงชัย", school_id: school_a.id, number: 2 })
  b13 = Student.create({ student_number: 2003, prefix: "ด.ญ.", first_name: "กัญญารัตน์", last_name: "ทองคงอ่วม", school_id: school_a.id, number: 3 })
  b14 = Student.create({ student_number: 2004, prefix: "ด.ช.", first_name: "กันตพงศ์", last_name: "กุมกัน", school_id: school_a.id, number: 4 })
  b15 = Student.create({ student_number: 2005, prefix: "ด.ช.", first_name: "กิตติ", last_name: "นิลบดี", school_id: school_a.id, number: 5 })
  b16 = Student.create({ student_number: 2006, prefix: "ด.ช.", first_name: "กิตติศักดิ์", last_name: "ทรงปัญญาเลิศ", school_id: school_a.id, number: 6 })
  b17 = Student.create({ student_number: 2007, prefix: "ด.ช.", first_name: "คัมภีร์", last_name: "ลาวหาง", school_id: school_a.id, number: 7 })
  b18 = Student.create({ student_number: 2008, prefix: "ด.ช.", first_name: "จิรพันธิ์", last_name: "เทพมะณี", school_id: school_a.id, number: 8 })
  b19 = Student.create({ student_number: 2009, prefix: "ด.ญ.", first_name: "จุฑามาศ", last_name: "แก้วตุ้ย", school_id: school_a.id, number: 9 })
  b20 = Student.create({ student_number: 2010, prefix: "ด.ช.", first_name: "เฉลิมชัย", last_name: "อยู่มาก", school_id: school_a.id, number: 10 })
  b21 = Student.create({ student_number: 2011, prefix: "ด.ญ.", first_name: "ทิพยภรณ์", last_name: "ปันมี", school_id: school_a.id, number: 11 })
  b22 = Student.create({ student_number: 2012, prefix: "ด.ช.", first_name: "ธราดล", last_name: "เตจา", school_id: school_a.id, number: 12 })
  b23 = Student.create({ student_number: 2013, prefix: "ด.ช.", first_name: "ธราธร", last_name: "ไลไธสง", school_id: school_a.id, number: 13 })
  b24 = Student.create({ student_number: 2014, prefix: "ด.ญ.", first_name: "นนทกาญจน์", last_name: "กองมา", school_id: school_a.id, number: 14 })
  b25 = Student.create({ student_number: 2015, prefix: "ด.ญ.", first_name: "นพมาศ", last_name: "หมื่นอ้าย", school_id: school_a.id, number: 15 })
  b26 = Student.create({ student_number: 2016, prefix: "ด.ญ.", first_name: "นริศรา", last_name: "ตุ่นป้อ", school_id: school_a.id, number: 16 })
  b27 = Student.create({ student_number: 2017, prefix: "ด.ญ.", first_name: "นิศาชล", last_name: "วงค์ษา", school_id: school_a.id, number: 17 })
  b28 = Student.create({ student_number: 2018, prefix: "ด.ช.", first_name: "ผดุงเดช", last_name: "ชัยแก้ว", school_id: school_a.id, number: 18 })
  b29 = Student.create({ student_number: 2019, prefix: "ด.ญ.", first_name: "พนิตา", last_name: "เซ่งจ่าว", school_id: school_a.id, number: 19 })
  b30 = Student.create({ student_number: 2020, prefix: "ด.ช.", first_name: "พลวัชว์", last_name: "ฉายากร", school_id: school_a.id, number: 20 })
  b31 = Student.create({ student_number: 2021, prefix: "ด.ช.", first_name: "พีรพัฒน์", last_name: "เซ่งจ่าว", school_id: school_a.id, number: 21 })
  b32 = Student.create({ student_number: 2022, prefix: "ด.ช.", first_name: "มนัส", last_name: "ขอดคำ", school_id: school_a.id, number: 22 })
  b33 = Student.create({ student_number: 2023, prefix: "ด.ญ.", first_name: "รักษิณา", last_name: "ละทอง", school_id: school_a.id, number: 23 })
  b34 = Student.create({ student_number: 2024, prefix: "ด.ญ.", first_name: "รัตนาภรณ์", last_name: "ซิตี", school_id: school_a.id, number: 24 })
  b35 = Student.create({ student_number: 2025, prefix: "ด.ญ.", first_name: "รัตนาวลี", last_name: "จันทร์เทศ", school_id: school_a.id, number: 25})
  b36 = Student.create({ student_number: 2026, prefix: "ด.ญ.", first_name: "วทันยา", last_name: "แซ่เฒ่า", school_id: school_a.id, number: 26 })
  b37 = Student.create({ student_number: 2027, prefix: "ด.ญ.", first_name: "วราลี", last_name: "ศิริศิลป์ท้าว", school_id: school_a.id, number: 27 })
  b38 = Student.create({ student_number: 2028, prefix: "ด.ญ.", first_name: "วิธิดา", last_name: "โนรี", school_id: school_a.id, number: 28 })
  b39 = Student.create({ student_number: 2029, prefix: "ด.ช.", first_name: "วิศรุต", last_name: "กาฬภัคดี", school_id: school_a.id, number: 29 })
  b40 = Student.create({ student_number: 2030, prefix: "ด.ช.", first_name: "ศุกิจกานต์", last_name: "ใจอ่อน", school_id: school_a.id, number: 30 })
  b41 = Student.create({ student_number: 2031, prefix: "ด.ช.", first_name: "ศุติพล", last_name: "พนากำเนิด", school_id: school_a.id, number: 31 })
  b42 = Student.create({ student_number: 2032, prefix: "ด.ช.", first_name: "สมรักษ์", last_name: "", school_id: school_a.id, number: 32 })
  b43 = Student.create({ student_number: 2033, prefix: "ด.ญ.", first_name: "หมวย", last_name: "สมพงษ์", school_id: school_a.id, number: 33 })
  b44 = Student.create({ student_number: 2034, prefix: "ด.ญ.", first_name: "หมูหยอง", last_name: "ติบยา", school_id: school_a.id, number: 34 })
  b45 = Student.create({ student_number: 2035, prefix: "ด.ช.", first_name: "หว่า", last_name: "แซ่เล่า", school_id: school_a.id, number: 35 })
  b46 = Student.create({ student_number: 2036, prefix: "ด.ช.", first_name: "อดิศาร", last_name: "สุรินทร์", school_id: school_a.id, number: 36 })
  b47 = Student.create({ student_number: 2037, prefix: "ด.ช.", first_name: "อรรษฎา", last_name: "กูดแก้ว", school_id: school_a.id, number: 37 })
  b48 = Student.create({ student_number: 2038, prefix: "ด.ญ.", first_name: "อริสรา", last_name: "มาขันธ์", school_id: school_a.id, number: 38 })
  b49 = Student.create({ student_number: 2039, prefix: "ด.ช.", first_name: "นิรวิทธ์", last_name: "แช่ซ้ง", school_id: school_a.id, number: 39 })
  b50 = Student.create({ student_number: 2040, prefix: "ด.ญ.", first_name: "ชัยวัฒน์", last_name: "เลาย่าง", school_id: school_a.id, number: 40 })

  user_a = users[0]
  user_b = users.count > 1 ? users[1] : users[0]
  l11 = List.create({ name: "ม. 1/1", category: "roll_call", user_id: user_a.id })
  l12 = List.create({ name: "ม. 1/2", category: "roll_call", user_id: user_b.id })

  ClassPermision.create({list_id: l11.id, user_id: user_a.id })
  ClassPermision.create({list_id: l12.id, user_id: user_a.id })
  ClassPermision.create({list_id: l11.id, user_id: user_b.id })
  ClassPermision.create({list_id: l12.id, user_id: user_b.id })

  StudentList.create({ student_id: a11.id, list_id: l11.id })
  StudentList.create({ student_id: a12.id, list_id: l11.id })
  StudentList.create({ student_id: a13.id, list_id: l11.id })
  StudentList.create({ student_id: a14.id, list_id: l11.id })
  StudentList.create({ student_id: a15.id, list_id: l11.id })
  StudentList.create({ student_id: a16.id, list_id: l11.id })
  StudentList.create({ student_id: a17.id, list_id: l11.id })
  StudentList.create({ student_id: a18.id, list_id: l11.id })
  StudentList.create({ student_id: a19.id, list_id: l11.id })
  StudentList.create({ student_id: a20.id, list_id: l11.id })
  StudentList.create({ student_id: a21.id, list_id: l11.id })
  StudentList.create({ student_id: a22.id, list_id: l11.id })
  StudentList.create({ student_id: a23.id, list_id: l11.id })
  StudentList.create({ student_id: a24.id, list_id: l11.id })
  StudentList.create({ student_id: a25.id, list_id: l11.id })
  StudentList.create({ student_id: a26.id, list_id: l11.id })
  StudentList.create({ student_id: a27.id, list_id: l11.id })
  StudentList.create({ student_id: a28.id, list_id: l11.id })
  StudentList.create({ student_id: a29.id, list_id: l11.id })
  StudentList.create({ student_id: a30.id, list_id: l11.id })
  StudentList.create({ student_id: a31.id, list_id: l11.id })
  StudentList.create({ student_id: a32.id, list_id: l11.id })
  StudentList.create({ student_id: a33.id, list_id: l11.id })
  StudentList.create({ student_id: a34.id, list_id: l11.id })
  StudentList.create({ student_id: a35.id, list_id: l11.id })
  StudentList.create({ student_id: a36.id, list_id: l11.id })
  StudentList.create({ student_id: a37.id, list_id: l11.id })
  StudentList.create({ student_id: a38.id, list_id: l11.id })
  StudentList.create({ student_id: a39.id, list_id: l11.id })
  StudentList.create({ student_id: a40.id, list_id: l11.id })
  StudentList.create({ student_id: a41.id, list_id: l11.id })
  StudentList.create({ student_id: a42.id, list_id: l11.id })
  StudentList.create({ student_id: a43.id, list_id: l11.id })
  StudentList.create({ student_id: a44.id, list_id: l11.id })
  StudentList.create({ student_id: a45.id, list_id: l11.id })
  StudentList.create({ student_id: a46.id, list_id: l11.id })
  StudentList.create({ student_id: a47.id, list_id: l11.id })
  StudentList.create({ student_id: a48.id, list_id: l11.id })
  StudentList.create({ student_id: a49.id, list_id: l11.id })
  StudentList.create({ student_id: a50.id, list_id: l11.id })

  StudentList.create({ student_id: b11.id, list_id: l12.id })
  StudentList.create({ student_id: b12.id, list_id: l12.id })
  StudentList.create({ student_id: b13.id, list_id: l12.id })
  StudentList.create({ student_id: b14.id, list_id: l12.id })
  StudentList.create({ student_id: b15.id, list_id: l12.id })
  StudentList.create({ student_id: b16.id, list_id: l12.id })
  StudentList.create({ student_id: b17.id, list_id: l12.id })
  StudentList.create({ student_id: b18.id, list_id: l12.id })
  StudentList.create({ student_id: b19.id, list_id: l12.id })
  StudentList.create({ student_id: b20.id, list_id: l12.id })
  StudentList.create({ student_id: b21.id, list_id: l12.id })
  StudentList.create({ student_id: b22.id, list_id: l12.id })
  StudentList.create({ student_id: b23.id, list_id: l12.id })
  StudentList.create({ student_id: b24.id, list_id: l12.id })
  StudentList.create({ student_id: b25.id, list_id: l12.id })
  StudentList.create({ student_id: b26.id, list_id: l12.id })
  StudentList.create({ student_id: b27.id, list_id: l12.id })
  StudentList.create({ student_id: b28.id, list_id: l12.id })
  StudentList.create({ student_id: b29.id, list_id: l12.id })
  StudentList.create({ student_id: b30.id, list_id: l12.id })
  StudentList.create({ student_id: b31.id, list_id: l12.id })
  StudentList.create({ student_id: b32.id, list_id: l12.id })
  StudentList.create({ student_id: b33.id, list_id: l12.id })
  StudentList.create({ student_id: b34.id, list_id: l12.id })
  StudentList.create({ student_id: b35.id, list_id: l12.id })
  StudentList.create({ student_id: b36.id, list_id: l12.id })
  StudentList.create({ student_id: b37.id, list_id: l12.id })
  StudentList.create({ student_id: b38.id, list_id: l12.id })
  StudentList.create({ student_id: b39.id, list_id: l12.id })
  StudentList.create({ student_id: b40.id, list_id: l12.id })
  StudentList.create({ student_id: b41.id, list_id: l12.id })
  StudentList.create({ student_id: b42.id, list_id: l12.id })
  StudentList.create({ student_id: b43.id, list_id: l12.id })
  StudentList.create({ student_id: b44.id, list_id: l12.id })
  StudentList.create({ student_id: b45.id, list_id: l12.id })
  StudentList.create({ student_id: b46.id, list_id: l12.id })
  StudentList.create({ student_id: b47.id, list_id: l12.id })
  StudentList.create({ student_id: b48.id, list_id: l12.id })
  StudentList.create({ student_id: b49.id, list_id: l12.id })
  StudentList.create({ student_id: b50.id, list_id: l12.id })
end
