*** Settings ***
Resource               ../keywords/common.robot
Test Setup             Setup
Test Teardown          Tear Down
Library                DateTime

*** Test Cases ***
### Link to testcases https://docs.google.com/spreadsheets/d/1R_jW5GBVBaMy7YgNKJQ2Ha5xW12Vn0nRzOHE0-OsyF8/edit#gid=1432644075 ###
PL_01 Verify the User Interface of "Danh sách Post" page
  [Tags]                                                                                                MainPage                   UI                     Smoketest
  Login to admin
  When Click "Thiết lập" menu
  When Click "Post" sub menu to "/setting/post"
  Then Heading should contain "Danh sách Post" inner text
  Then Confirm locating exactly in "Post" page of "Thiết lập" menu
  Then Webpage should contain the list data from database
  Then Webpage should contain the search function
  Then Webpage should contain "Tên Post" column with sort and search function
  Then Webpage should contain "Slug" column with sort and search function
  Then Webpage should contain "Created" column with sort and search function
  Then Webpage should contain "Post Type" group
  Then Webpage should contain "Tạo mới" button

PL_02 Verify the User Interface of "Danh sách Post" page in "Projects" category
  [Tags]                                                                                                MainPage                   UI                     Projects
  Login to admin
  When Click "Thiết lập" menu
  When Click "Post" sub menu to "/setting/post"
  Then Click on "second" selection to change the number of data show in list and check
  Then Click on "third" selection to change the number of data show in list and check
  Then Click on "fourth" selection to change the number of data show in list and check
  Then Click on "fifth" selection to change the number of data show in list and check

PL_03 Verify the function of changing the page's number the list of posts in "Projects" category
  [Tags]                                                                                                MainPage                   UI                     Projects
  Go to "Danh sách Post" page with "Projects" list
  Then Check the amount of page list
       ${Last_name}=            Get data in the last row
  When Create a test post in "Project" list
  When Move to the "next" page
       ${First_name}=           Get data in the first row
  Then Should Be Equal          ${First_name}    ${Last_name}
  When Move to the "perious" page
  When Click on the "Xóa" button in the "_@Name@_" table line 
  When Move to the last page and check

PL_04 Verify the highlight table line function after operated in "Projects" category
  [Tags]                                                                                                MainPage                   UI                     Projects
  Create a test post in "Projects" list
  When Click on the "Sửa" button in the "_@Name@_" table line
  When Click "Huỷ bỏ" button
  Then "_@Name@_" table line should be highlighted
  When Click on the "Xóa" button in the "_@Name@_" table line

PL_05 Verify the User Interface of "Danh sách Post" page in "News" category
  [Tags]                                                                                                MainPage                   UI                     News
  Login to admin
  When Click "Thiết lập" menu
  When Click "Post" sub menu to "/setting/post"
  Then Click on "second" selection to change the number of data show in list and check
  Then Click on "third" selection to change the number of data show in list and check
  Then Click on "fourth" selection to change the number of data show in list and check
  Then Click on "fifth" selection to change the number of data show in list and check

PL_06 Verify the function of changing the page's number the list of posts in "News" category
  [Tags]                                                                                                MainPage                   UI                     News
  Go to "Danh sách Post" page with "News" list
  Then Check the amount of page list
       ${Last_name}=            Get data in the last row
  When Create a test post in "Project" list
  When Move to the "next" page
       ${First_name}=           Get data in the first row
  Then Should Be Equal          ${First_name}    ${Last_name}
  When Move to the "perious" page
  When Click on the "Xóa" button in the "_@Name@_" table line 
  When Move to the last page and check

PL_07 Verify the highlight table line function after operated in "News" category
  [Tags]                                                                                                MainPage                   UI                     News
  Create a test post in "News" list
  When Click on the "Sửa" button in the "_@Name@_" table line
  When Click "Huỷ bỏ" button
  Then "_@Name@_" table line should be highlighted
  When Click on the "Xóa" button in the "_@Name@_" table line

### Verify the activate function ###
PL_08 Verify that switch off post when click on "Đã kích hoạt" button
  [Tags]                                                                                                MainPage                   UI                     News
  Create a test post in "Projects" list
  When Click on the "Đã kích hoạt" button in the "_@Name@_" table line
  Then User look message "Cập nhật thành công" popup
  Then The status button in the "_@Name@_" table line should change to "Đã vô hiệu hóa"
  When Click on the "Xóa" button in the "_@Name@_" table line


*** Keywords ***
Go to "Danh sách Post" page with "${category}" list
  Login to admin
  Click "Thiết lập" menu
  Click "Post" sub menu to "/setting/post"
  Select on the "${category}" item line

### Post ###
Create a test post in "${category}" list
  ${condition}=            Run Keyword And Return Status            Confirm locating exactly in "Post" page of "Thiết lập" menu
  IF    '${condition}' == 'True'
    Select on the "${category}" item line
    Click "Tạo mới" button
  ELSE
    Go to "Danh sách Post" page with "${category}" list
    Click "Tạo mới" button
  END
  Click "date" in "Created At" with "today"
  Select file in "Thumbnail Url" with "image.jpg"
  Click on "ENGLISH" tab
  Enter "test name" in "Name" with "_RANDOM_"
  Enter "paragraph" in textarea "Description" with "_RANDOM_"
  Enter "paragraph" in editor "Content" with "_RANDOM_"
  Click on "VIETNAM" tab
  Enter "test name" in "Name" with "_RANDOM_"
    ${name}=               Check Text                               _@Name@_
    [Return]               ${name}
  Enter "paragraph" in textarea "Description" with "_RANDOM_"
  Enter "paragraph" in editor "Content" with "_RANDOM_"
  Click "Lưu lại" button
  User look message "Tạo thành công" popup

Create a test post in "${category}" list with "${name}" in data name
  ${name}=                 Get Random Text                          test name                 ${name}
  ${condition}=            Run Keyword And Return Status            Confirm locating exactly in "Post" page of "Thiết lập" menu
  IF    '${condition}' == 'True'
    Select on the "${category}" item line
    Click "Tạo mới" button
  ELSE
    Go to "Danh sách Post" page with "${category}" list
    Click "Tạo mới" button
  END
  Click "date" in "Created At" with "today"
  Select file in "Thumbnail Url" with "image.jpg"
  Click on "ENGLISH" tab
  Enter "test name" in "Name" with "_RANDOM_"
  Enter "paragraph" in textarea "Description" with "_RANDOM_"
  Enter "paragraph" in editor "Content" with "_RANDOM_"
  Click on "VIETNAM" tab
  Enter "test name" in "Name" with "${name}"
    [Return]               ${name}
  Enter "paragraph" in textarea"Description" with "_RANDOM_"
  Enter "paragraph" in "Content" with "_RANDOM_"
  Click "Lưu lại" button
  User look message "Tạo thành công" popup

# Create a test post in "${category}" list with "${order}" in order
#   ${name}=                 Get Random Text                          number                    ${order}
#   ${condition}=            Run Keyword And Return Status            Confirm locating exactly in "Post" page of "Thiết lập" menu
#   IF    '${condition}' == 'True'
#     Select on the "${category}" item line
#     Click "Tạo mới" button
#   ELSE
#     Go to "Danh sách Post" page with "${category}" list
#     Click "Tạo mới" button
#   END
#   Enter "number" in "Order" with "${order}"
#   Select file in "Ảnh" with "image.jpg"
#   Click on "ENGLISH" tab
#   Enter "test name" in "Name" with "_RANDOM_"
#   Enter "paragraph" in "Description" with "_RANDOM_"
#   Enter "paragraph" in "Content" with "_RANDOM_"
#   Click on "VIETNAM" tab
#   Enter "test name" in "Name" with "_RANDOM_"
#     ${name}=               Check Text                               _@Name@_
#     [Return]               ${name}
#   Enter "paragraph" in "Description" with "_RANDOM_"
#   Enter "paragraph" in "Content" with "_RANDOM_"
#   Click "Lưu lại" button
#   User look message "Tạo thành công" popup
