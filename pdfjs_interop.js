async function extractTextFromPDF(pdfUrl) {
    try {
        const loadingTask = pdfjsLib.getDocument(pdfUrl);
        const pdf = await loadingTask.promise;
        let extractedText = '';

        for (let pageNum = 1; pageNum <= pdf.numPages; pageNum++) {
            const page = await pdf.getPage(pageNum);
            const textContent = await page.getTextContent();
            textContent.items.forEach(function (textItem) {
                extractedText += textItem.str + ' ';
            });
        }

        return extractedText;
    } catch (error) {
        console.error('Error extracting text from PDF:', error);
        throw error;
    }
}

window.extractTextFromPDF = extractTextFromPDF;