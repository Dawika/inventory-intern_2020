function search() {
    $('#table').bootstrapTable('refresh', {
        query: {
            search: $("input#search").val()
        }
    });
    $('#table').bootstrapTable('refreshOptions', {
        pageNumber: 1
    });
}

function filter() {
    var print_link = "/students.pdf?for_print=true";
    print_link += "&grade_select=" + $("select#grade_select").val()
    print_link += "&class_select=" + $("select#class_select").val()
    $('#print-student-list-with-image').attr('href', print_link);
    $('#table').bootstrapTable('refresh', {
        query: {
            offset: 0,
            grade_select: $("select#grade_select").val(),
            class_select: $("select#class_select").val()
        }
    });
    $('#table').bootstrapTable('refreshOptions', {
        pageNumber: 1
    });
}

function queryParams(p) {
    window.paramOder = p.order || p.sortOrder
    window.paramSort = p.sort || p.sortName
    return {
        page: p.pageNumber,
        per_page: p.pageSize,
        offset: p.offset,
        limit: p.limit,
        order: window.paramOder,
        sort: window.paramSort,
        search: $("input#search").val(),
        grade_select: $("select#grade_select").val(),
        class_select: $("select#class_select").val()
    };
}

function cellStyle(value, row, index) {
    return {
        css: {
            "text-align": "center"
        }
    };
}

function exportTable(tableName) {

    var url = tableName + '.json?order=' + window.paramOder + '&sort=' + window.paramSort + '&search=' + $("input#search").val() + '&grade_select=' + $("select#grade_select").val() + '&class_select=' + $("select#class_select").val()

    $table = $('#tableForExport')
    $.get(url, function(data) {
        $table.bootstrapTable('load', data.rows)
        $table.tableExport({
            type: 'excel'
        });
    });
}

function imgTag(value, row, index) {
    if (value) {
        return '<div class="img-bg circle" style="background: url(' + value + ')"></div>';
    }
    return '<div class="img-bg bg-light-gray circle"><i class="fa fa-user icon-default-img" aria-hidden="true"></i></div>'
}

function selectionStudentFormatter(value, row, index) {
    var html =
        '<span class="dropdown float-right cursor-pointer">' +
        '<span div data-toggle="dropdown" id="options' + row.id + '">' +
        "<a class='color-blue-link'>" + I18n.t("choice") + "<i class='fa fa-angle-down ml-5'></i></a>" +
        '</span>' +
        '<ul class="dropdown-menu dropdown-menu-right" aria-labelledby="options' + row.id + '">' +
        '<li>' +
        "<a href='/students/" + row.id + "/edit'>" +
        "<i class='fa fa-pencil-square-o fa-fw' aria-hidden='true'></i>&nbsp;" + I18n.t("edit") +
        '</a>' +
        '</li>' +
        '<li>' +
        "<a onclick='openResignStudentModal(" + row.id + ")'>" +
        "<i class='fa fa-share-square-o color-orange fa-fw' aria-hidden='true'></i>&nbsp;" + I18n.t("resign") +
        '</a>' +
        '</li>' +
        '<li>' +
        "<a onclick='openGraduateStudentModal(" + row.id + ")'>" +
        "<i class='fa fa-graduation-cap color-green fa-fw' aria-hidden='true'></i>&nbsp;" + I18n.t("gradulated") +
        '</a>' +
        '</li>' +
        '<li>' +
        "<a onclick='openDeletedStudentModal(" + row.id + ")'>" +
        "<i class='fa fa-trash color-red fa-fw' aria-hidden='true'></i>&nbsp;" + I18n.t("delete") +
        '</a>' +
        '</li>' +
        '</ul>' +
        '</span>';
    return html
}

function linkToStudentEditFormatter(value, row, index) {
    return "<a class='color-blue-link' href='/students/" + row.id + "/edit'>" + row.full_name + "</a>"
}

function openDeletedStudentModal(id) {
    $('#warningModal #modal-title').html(I18n.t("del_student"))
    $('#warningModal #actionModalForm').prop("action", "/students/" + id)
    $('#warningModal #actionModalForm').append('<input type="hidden" name="_method" value="delete">')
    $('#warningModal #actionModalForm').prop("method", "post")
    $('#warningModal').modal()
}

function openResignStudentModal(id) {
    $('#warningModal #modal-title').html(I18n.t("change_status_student_resign"))
    $('#warningModal #actionModalForm').prop("action", "/students/" + id + "/resign")
    $('#warningModal #actionModalForm').prop("method", "post")
    $('#warningModal').modal()
}

function openGraduateStudentModal(id) {
    $('#warningModal #modal-title').html(I18n.t("change_status_student_graduated"))
    $('#warningModal #actionModalForm').prop("action", "/students/" + id + "/graduate")
    $('#warningModal #actionModalForm').prop("method", "post")
    $('#warningModal').modal()
}

function selectionParentFormatter(value, row, index) {
    if (row.parents && row.parents.id) {
        var id = row.parents.id
        var html =
            '<span class="dropdown float-right cursor-pointer cursor-pointer">' +
            '<span div data-toggle="dropdown" id="options' + id + '">' +
            "<a class='color-blue-link'>" + I18n.t("choice") + "<i class='fa fa-angle-down ml-5'></i></a>" +
            '</span>' +
            '<ul class="dropdown-menu dropdown-menu-right" aria-labelledby="options' + id + '">' +
            '<li>' +
            "<a href='/parents/" + id + "/edit'>" +
            "<i class='fa fa-pencil-square-o fa-fw' aria-hidden='true'></i>&nbsp;" + I18n.t("edit") +
            '</a>' +
            '</li>' +
            '<li>' +
            "<a onclick='openDeletedParentModal(" + id + ")'>" +
            "<i class='fa fa-trash color-red fa-fw' aria-hidden='true'></i>&nbsp;" + I18n.t("delete") +
            '</a>' +
            '</li>' +
            '</ul>' +
            '</span>';
        return html
    } else {
        return ""
    }
}

function linkToParentEditFormatter(value, row, index) {
    if (row.parents) {
        return "<a class='color-blue-link' href='/parents/" + row.parents.id + "/edit'>" + row.parents.full_name + "</a>"
    } else {
        return ""
    }

}

function openDeletedParentModal(id) {
    $('#warningModal #modal-title').html(I18n.t("del_parent"))
    $('#warningModal #actionModalForm').prop("action", "/parents/" + id)
    $('#warningModal #actionModalForm').append('<input type="hidden" name="_method" value="delete">')
    $('#warningModal #actionModalForm').prop("method", "post")
    $('#warningModal').modal()
}

function getclassroom(url) {
    $.ajax({
        url: url,
        dataType: 'json',
        data: {
            grade_select: $("select#grade_select").val()
        },
        success: function(response) {
            $("#class_select option[value!='all']").remove();
            if ($("#class_select option[value!='all']")) {
                var select = document.getElementById("class_select");
                if (response.class != null) {
                    for (var i = 0; i < response.class.length; i++) {
                        var option = document.createElement("option");
                        option.text += response.class[i];
                        select.add(option);
                    }

                }
            }

        }
    });
}

function toggleImportSection() {
    var button_import = $('#importSection')
    button_import.is(':hidden') ? button_import.show() : button_import.hide()
}