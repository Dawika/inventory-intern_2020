User.delete_all
School.delete_all
Employee.delete_all
Payroll.delete_all
TaxReduction.delete_all

if School.count == 0
School.create!([
  {id: 1, name: "Sunshine Kindergarten"},
  {id: 2, name: "Testing School"},
])
end

if User.count == 0
User.create!([
  {email: "test@test.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, school_id: 1, name: nil},
  {email: "admin@bananacoding.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2016-12-26 07:33:11", last_sign_in_at: "2016-12-26 07:28:33", current_sign_in_ip: "180.183.204.78", last_sign_in_ip: "180.183.204.78", school_id: 1, name: nil},
  {email: "manit@bananacoding.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2016-12-26 10:25:26", last_sign_in_at: "2016-12-26 08:19:32", current_sign_in_ip: "::1", last_sign_in_ip: "58.11.94.19", school_id: 1, name: nil},
  {email: "putamthong@gmail.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2016-12-27 02:20:42", last_sign_in_at: "2016-12-27 02:20:42", current_sign_in_ip: "::1", last_sign_in_ip: "::1", school_id: 1, name: nil},
  {email: "admin@sunshinekindergarten.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, school_id: 1, name: nil},
  {email: "testing.school@test.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, school_id: 2, name: nil}
])
end

if Employee.count == 0
Employee.create!([
  {id: 1, school_id: 1, first_name: "Christine", last_name: "Pronske", middle_name: "Michelle", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-08688-37-3", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Christine", start_date: "2016-10-31 08:48:03"},
  {id: 2, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-9098-00264-76-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ปรารถนา", last_name_thai: "วารีดำ", prefix_thai: "นางสาว", nickname: "Shaylene", start_date: "2014-05-25 17:00:00"},
  {id: 3, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5602-00071-31-2", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "พรศิรินทร์", last_name_thai: "กล้วยไม้ ณ อยุธยา", prefix_thai: "นางสาว", nickname: "ปูเป้", start_date: "2016-10-30 17:00:00"},
  {id: 4, school_id: 1, first_name: "Patra", last_name: "Capelli", middle_name: "", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "1-1002-00225-01-1", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "", last_name_thai: "", prefix_thai: "", nickname: "Patty", start_date: "2015-05-17 17:00:00"},
  {id: 5, school_id: 1, first_name: "Philip", last_name: "Keidaish III", middle_name: "Frederic", prefix: "Mr", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-11480-13-3", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Philip", start_date: "2016-05-09 17:00:00"},
  {id: 6, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-5099-00391-90-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ทิตยา", last_name_thai: "เป็งธรรม", prefix_thai: "นางสาว", nickname: "ฟาง", start_date: "2011-08-14 17:00:00"},
  {id: 7, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "3-5002-00917-77-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "รำพรรณ", last_name_thai: "วังทอง", prefix_thai: "นาง", nickname: "อ้อย", start_date: "2013-03-31 17:00:00"},
  {id: 8, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-6405-00056-74-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ผกามาศ", last_name_thai: "ตระกูลอินทร์", prefix_thai: "นางสาว", nickname: "กา", start_date: "2013-10-08 17:00:00"},
  {id: 9, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-6406-00014-93-5", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ดนุดา", last_name_thai: "ยนต์นิยม", prefix_thai: "นางสาว", nickname: "นุ๊ก", start_date: "2013-10-31 17:00:00"},
  {id: 10, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-8607-00010-01-8", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ธนพร", last_name_thai: "โชติพรหมราช", prefix_thai: "นางสาว", nickname: "อ้อย", start_date: "2015-04-10 17:00:00"},
  {id: 11, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "3-1005-03132-56-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ปภัศสา", last_name_thai: "ปทุมวัฒน์", prefix_thai: "นางสาว", nickname: "ทราย", start_date: "2015-10-18 17:00:00"},
  {id: 12, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-5099-00299-82-9", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "หนึ่งฤทัย", last_name_thai: "ไชยจินดา", prefix_thai: nil, nickname: "เมย์", start_date: "2016-08-03 17:00:00"},
  {id: 13, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-5099-00279-95-0", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อัมภวรรณ", last_name_thai: "ปินตา", prefix_thai: "นางสาว", nickname: "ออฟ", start_date: "2016-10-09 17:00:00"},
  {id: 14, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5599-00176-56-5", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ศิริลักษณ์", last_name_thai: "ขันแก้ว", prefix_thai: "นางสาว", nickname: "นิก", start_date: "2015-10-18 17:00:00"},
  {id: 15, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5012-00078-43-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อาทิตยา", last_name_thai: "วงค์แสน", prefix_thai: "นางสาว", nickname: "น้ำหวาน", start_date: "2015-10-18 17:00:00"},
  {id: 16, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5099-00165-81-4", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ภรณ์ทิพย์", last_name_thai: "จันทร์ดี", prefix_thai: "นางสาว", nickname: "ก้อย", start_date: "2015-10-31 17:00:00"},
  {id: 17, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5099-00520-79-7", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "กมลพรรณ", last_name_thai: "ทาทอง", prefix_thai: "นาง", nickname: "นิต", start_date: "2015-11-01 17:00:00"},
  {id: 18, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-6304-00040-72-0", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อรนุช", last_name_thai: "ทับศรีรักษ์", prefix_thai: "นางสาว", nickname: "แอร์", start_date: "2015-12-13 17:00:00"},
  {id: 19, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5007-00116-22-6", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อลิสรา", last_name_thai: "ทองชิว", prefix_thai: "นางสาว", nickname: "แอลลี่", start_date: "2016-10-09 17:00:00"},
  {id: 20, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูคู่ชั้น", personal_id: "1-5599-00196-49-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ศิริพร", last_name_thai: "พรหมโชติ", prefix_thai: "นางสาว", nickname: "เจ", start_date: "2016-10-30 17:00:00"},
  {id: 21, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูพี่เลี้ยง", personal_id: "1-5018-00053-91-0", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อัมรา", last_name_thai: "บุญปัน", prefix_thai: "นางสาว", nickname: "เหมียว", start_date: "2016-04-17 17:00:00"},
  {id: 22, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูพี่เลี้ยง", personal_id: "1-5099-00922-00-3", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "อังคณา", last_name_thai: "ยาสมุทร", prefix_thai: "นางสาว", nickname: "เนส", start_date: "2016-06-22 17:00:00"},
  {id: 23, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูวิชาการ", personal_id: "3-7403-00343-54-8", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "สรญา", last_name_thai: "ออลมาร์ก เพื่อ ด.ช. สรัชชพงศ์ เชี่ยวสุทธิ", prefix_thai: "นาง", nickname: "มด", start_date: "2016-06-22 17:00:00"},
  {id: 24, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ธุรการ", personal_id: "1-5099-00715-54-7", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "พัชราภรณ์", last_name_thai: "คำแก้ว", prefix_thai: "นางสาว", nickname: "มิ้นท์", start_date: "2016-11-10 17:00:00"},
  {id: 25, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "บัญชีการเงิน", personal_id: "3-1014-01790-69-4", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "สุภาพร", last_name_thai: "แต้มทอง", prefix_thai: "นางสาว", nickname: "ปู", start_date: "2016-01-08 17:00:00"},
  {id: 26, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "การตลาด", personal_id: "1-5099-00216-42-7", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ณัฐรดี", last_name_thai: "เกี๋ยงเหมย", prefix_thai: "นางสาว", nickname: "แอม", start_date: "2016-07-31 17:00:00"},
  {id: 27, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ครูผู้สอน", personal_id: "1-6001-00221-12-5", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "30000.0", img_url: "", first_name_thai: "ชนินทร", last_name_thai: "ศรีป้อม", prefix_thai: "นางสาว", nickname: "ดิว", start_date: "2011-08-14 17:00:00"},
  {id: 28, school_id: 1, first_name: "Eliane", last_name: "Mortreux", middle_name: "", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-11479-98-4", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "35000.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Elly", start_date: "2015-06-07 17:00:00"},
  {id: 29, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "ผู้อำนวยการโรงเรียน", personal_id: "3-5190-00042-61-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "รัชนีบูลย์", last_name_thai: "เกริกไกวัล", prefix_thai: "นาง", nickname: "คุณแม่", start_date: "2014-07-15 17:00:00"},
  {id: 30, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "แม่ครัว", personal_id: "3-6009-00570-03-1", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "จันทร์ฉาย", last_name_thai: "บัวย้อย", prefix_thai: "นาง", nickname: "ป้าจันทร์", start_date: "2012-08-20 17:00:00"},
  {id: 31, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "แม่บ้าน", personal_id: "3-5001-00121-17-9", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "ศรีพรรณ", last_name_thai: "คำหล้า", prefix_thai: "นาง", nickname: "ป้าพรรณ", start_date: "2014-05-31 17:00:00"},
  {id: 32, school_id: 1, first_name: "", last_name: "", middle_name: "", prefix: "", sex: 0, position: "แม่บ้าน", personal_id: "3-5012-00772-28-8", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "พจนีย์", last_name_thai: "ศรีปา", prefix_thai: "นางสาว", nickname: "แวว", start_date: "2016-11-13 17:00:00"},
  {id: 33, school_id: 1, first_name: "Sai  Bawga", last_name: "Bawga", middle_name: "", prefix: "Mr", sex: 0, position: "รปภ.", personal_id: "", passport_number: "00-5001-117655-5", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "กล้า", start_date: "2014-06-30 17:00:00"},
  {id: 34, school_id: 1, first_name: "Nan  Hseng", last_name: "Mwam", middle_name: "", prefix: "Ms", sex: 0, position: "แม่บ้าน", personal_id: "", passport_number: "", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: "", last_name_thai: nil, prefix_thai: nil, nickname: "หนิง", start_date: "2015-05-18 17:00:00"},
  {id: 35, school_id: 1, first_name: "Samantha", last_name: "Loyd", middle_name: "Natasha", prefix: "Ms", sex: 0, position: "ครูผู้สอน", personal_id: "", passport_number: "0-9910-09778-98-8", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "0.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Sammy", start_date: nil},
  {id: 36, school_id: 2, first_name: "Another", last_name: "School", middle_name: "", prefix: "This is", sex: 0, position: "ครูผู้2", personal_id: "", passport_number: "0-9910-09778-98-8", race: "", nationality: "", bank_name: "", bank_branch: "", account_number: "000-0-00000-0", salary: "30000.0", img_url: "", first_name_thai: nil, last_name_thai: nil, prefix_thai: nil, nickname: "Sammy", start_date: nil}
])
end

if Payroll.count == 0
date_now = DateTime.now
Payroll.create!([
  {employee_id: 1, salary: "34000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "2000.0", social_insurance: "750.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 2, salary: "25500.0", allowance: "0.0", attendance_bonus: "0.0", ot: "2000.0", bonus: "0.0", position_allowance: "1000.0", extra_etc: "10000.0", absence: "0.0", late: "0.0", tax: "1300.0", social_insurance: "750.0", fee_etc: "20.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 3, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 4, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 5, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 6, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 7, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 8, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 9, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 10, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 11, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 12, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 13, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 14, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 15, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 16, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 17, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 18, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 19, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 20, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 21, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 22, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 23, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 24, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 25, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 26, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 27, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 28, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 29, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 30, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 31, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 32, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 33, salary: "35000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "1050.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 34, salary: "30000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "750.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 35, salary: "0.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 36, salary: "30000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: date_now},
  {employee_id: 1, salary: "30000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "1000.0", pvf: "0.0", advance_payment: "0.0", effective_date: (date_now - 1.month).to_datetime},
  {employee_id: 1, salary: "2000.0", allowance: "0.0", attendance_bonus: "0.0", ot: "0.0", bonus: "0.0", position_allowance: "0.0", extra_etc: "0.0", absence: "0.0", late: "0.0", tax: "0.0", social_insurance: "0.0", fee_etc: "0.0", pvf: "0.0", advance_payment: "0.0", effective_date: (date_now - 2.month).to_datetime}
])
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
