class @NoteAttachmentUploader

    #return promise
    upload:(note, file)->
        url = note.attachmentUploadUrl()
        $.ajax({
            url: url,
            type: 'POST',
            processData: false,
            contentType: false,
            data: @createFormData(file)
        })

    createFormData:(file)->
        fd = new FormData()
        fd.append('note_attachment[attachment]', file)
        csrfToken = $('meta[name="csrf-token"]').attr('content')
        fd.append("authenticity_token", csrfToken)
        fd
