<template>
    <div class="card-panel">
        <div class="fr-sb">
        <div class="header">
            <i class="medium material-icons">domain</i>
            <h3>IPCR Tracker</h3>
        </div>
        <div class="btn-container">
            <button @click="this.excelExport" class="btn-large waves-effect waves-lighen green accent-4"><i class="material-icons left">file_download</i>Download as Excel File</button>
        </div>
    </div>
    <div class="map-table" @mousedown="this.startDrag" ref="mapTable">
        <table class="centered">
            <thead>
                <tr>
                    <th class="map-th">
                        <p>Duties / Targets</p>
                    </th>
                    <th :colspan="this.officers.length" class="map-th">
                        <p>Action Officers</p>
                    </th>
                </tr>
                <tr>
                    <th class="map-th"></th>
                    <th v-for="(officer, index) in this.officers" :key="index" class="map-th">
                        {{ officer.name }}
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(duty, dutyIndex) in this.duties" :key="dutyIndex" class="map-tr">
                    <th class="map-th">
                        {{ duty.title }}
                    </th>
                    <td v-for="(officer, officerIndex) in this.officers" :key="officerIndex" class="map-td" :style="{
                        backgroundColor: highlightCell(officerIndex, dutyIndex) ? '#ffff00' : ''
                    }">
                        <div v-for="(assignedDuty, index) in this.assignedDuties" :key="index">
                            <p v-if="'o' + assignedDuty.officer_index + 'd' + assignedDuty.duty_index === 'o' + officerIndex + 'd' + dutyIndex">
                                {{ assignedDuty.date }} <br> {{ assignedDuty.code }}
                            </p>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    </div>
</template>

<script>
import ExcelJS from 'exceljs';
export default {
    name: 'IpcrTable',
    data() {
        return {
            isDragging: false,
            startX: 0,
            startY: 0,
            scrollLeft: 0,
            scrollTop: 0
        };
    },

    computed: {
        // get data from store
        officers() {
           return this.$store.getters.officers;
        },

        duties() {
            return this.$store.getters.duties;
        },

        assignedDuties() {
            return this.$store.getters.assignedDuties;
        }
    },

    methods: {
        highlightCell(officerIndex, dutyIndex) {
            // return true if the index passed is matched on some index on assignedDuties
            return this.assignedDuties.some(
                (assignedDuty) => 'o' + assignedDuty.officer_index + 'd' + assignedDuty.duty_index === 'o' + officerIndex + 'd' + dutyIndex
            )
        },

        startDrag(e) {
            // store current mouse position and div scroll position
            this.isDragging = true;
            this.startX = e.clientX;
            this.startY = e.clientY;
            this.scrollLeft = this.$refs.mapTable.scrollLeft;
            this.scrollTop = this.$refs.mapTable.scrollTop;

            // prevent text selection
            this.$refs.mapTable.style.userSelect = "none";
            this.$refs.mapTable.style.cursor = "grabbing";

            // add event listeners for mousemove and mouseup
            document.addEventListener("mousemove", this.handleDrag);
            document.addEventListener("mouseup", this.stopDrag);
        },

        handleDrag(e) {
            if (this.isDragging) {
                // calculate how far the mouse has moved
                const moveX = e.clientX - this.startX;
                const moveY = e.clientY - this.startY;

                // scroll the container accordingly
                this.$refs.mapTable.scrollLeft = this.scrollLeft - moveX;
                this.$refs.mapTable.scrollTop = this.scrollTop - moveY;
            }
        },

        stopDrag() {
            // stop dragging and reset cursor style
            this.isDragging = false;
            this.$refs.mapTable.style.cursor = "";

            // remove event listeners
            document.removeEventListener("mousemove", this.handleDrag);
            document.removeEventListener("mouseup", this.stopDrag);
        },

        // this excel export method is still not optimized and created on vanila javascript
        excelExport() {
            M.toast({
                html: '<p class="toast-text">Downloadng Excel File..<p>',
                displayLength: 5000
            })

            let workbook = new ExcelJS.Workbook(); // creare a new worksheet using ExcelJS
            let worksheet = workbook.addWorksheet("Sheet1") // add sheet named "Sheet 1"
            let table = document.querySelector('table')// Html Table

            // make the excel table
            let tableData = [] // table data 2d array
            const rowCount = table.rows.length; // count the number of rows needed
            
            // create the row
            const htmlTableRowToArray = (htmlTableRow) => {
                return Array.from(htmlTableRow.cells).map(cell => {
                    if (cell.textContent != '' && cell.querySelector("p")) { // check if there is a text on the cell "<p>"
                        return Array.from(cell.querySelectorAll("p")).map(p => p.textContent.trim() + "\n").join(" "); // format the cell texts accordingly
                    } else {
                        return cell.textContent.trim(); // trim whitespaces only for blank cells
                    }
                })
            }

            // create the 2d array
            for (let i = 0; i < rowCount; i++) {
                const htmlTableRow = htmlTableRowToArray(table.rows[i]); // create the rows
                tableData.push(htmlTableRow) // push the rows to 2d array
            }

            // console.table(tableData) // debug the table

            // functions

            // format selcted text color using rich text
            const formatTextColorGreen = (text) => {
                const regex = /(\([^)]+\))/g; // match to texts like "(text)"
                const textParts = text.split(regex); // split text into parts as needed in richText

                // map and transform into new array for richText
                return textParts.map(part => {
                    // check for matching texts on every part
                    if (regex.test(part)) {
                        // apply the green color on matching parts
                        return {font: {color: {argb: '008000'} }, text: part};
                    } else {
                        // apply nothing
                        return {text: part};
                    }
                });
            }

            // count the line breaks for cell height calculation
            const countLineBreaks = (cell) => {
                if (typeof cell !== 'string') return 0;
                const matches = cell.match(/\n/g);
                
                return matches ? matches.length : 0;
            }

            // create the excel table
            tableData.forEach((row, rowIndex) => {
                let worksheetRow = worksheet.addRow(row); // add tableData as rows
                let autoHeight = 0; // initalize height

                row.forEach((cellData, cellIndex) => {
                    
                    // determine the exact height of the row
                    let height = 100 + countLineBreaks(cellData) * 10; // compute the height
                    if (height > autoHeight) { // if height > current auto height
                        autoHeight = height; // set new auto height
                    }

                    // height
                    if (rowIndex <= 1) {
                        worksheet.getRow(rowIndex + 1).height = 40; // fixed height for the headers
                    } else {
                        worksheet.getRow(rowIndex + 1).height = autoHeight; // calculated height for the data rows
                    }

                    // width
                    worksheet.getColumn(cellIndex + 1).width = 30;

                    // apply cell styles
                    let cell = worksheetRow.getCell(cellIndex + 1);

                    // apply background color on cells with data
                    if (cellData !== '' && cellData != null) {
                        cell.fill = {
                            type: 'pattern',
                            pattern: 'solid',
                            fgColor: { argb: 'FFFF00' } // Apply yellow color for non-empty cells
                        };
                    }

                    // font color for codes
                    if (cellIndex !== 0 && typeof cellData === 'string') {
                        cell.value = {
                            richText: formatTextColorGreen(cellData)
                        }
                    } else {
                        cell.value = cellData;
                    }


                    // border
                    cell.border = {
                        top: { style: "medium", color: { argb: "000000" } },
                        left: { style: "medium", color: { argb: "000000" } },
                        bottom: { style: "medium", color: { argb: "000000" } },
                        right: { style: "medium", color: { argb: "000000" } },
                    }

                    // background color
                    if (rowIndex <= 1) {
                        cell.fill = {
                            type: "pattern",
                            pattern: "solid",
                            fgColor: { argb: "b2ebf2" },
                        };
                        
                        cell.font = {
                            bold: true,
                            size: 14
                        };
                    } else if (rowIndex % 2 === 1 && rowIndex > 2 && cellIndex != 0) {
                        if (cellData !== '' && cellData != null) {
                            cell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFFF00' } // Apply yellow color for non-empty cells
                            };
                        } else {
                            cell.fill = {
                                type: "pattern",
                                pattern: "solid",
                                fgColor: { argb: "f5f5f5" },
                            };
                        }
                    } else if (cellIndex === 0) {
                        cell.fill = {
                            type: "pattern",
                            pattern: "solid",
                            fgColor: { argb: "ff6e40" },
                        };

                        cell.font = {
                            bold: true,
                            size: 14
                        };
                    }

                    // text wrapping and alignment
                    cell.alignment = { vertical: "middle", horizontal: "center", wrapText: true };
                });
            });

            // cell merging for the header
            worksheet.mergeCells("B1:H1");

            // write the file then download
            workbook.xlsx.writeBuffer().then((buffer) => {
                let blob = new Blob([buffer], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                let link = document.createElement("a");
                link.href = URL.createObjectURL(blob);
                link.download = "IPCR.xlsx";
                link.click();
            });

        }
        
    },
}
</script>

<style scoped>
.header {
    display: flex;
    align-items: center;
    gap: 1rem;    
}

.map-table {
    max-height: 50rem;
    margin: 20px auto;
    overflow-x: auto;
}

.btn-container {
    padding-top: 1.5rem;
}

table {
    border-collapse: collapse;
}

.map-th, .map-td {
    border: 2px solid #000000;
    padding: 8px;
    text-align: center;
    min-width: 7rem;
}

.map-th {
    background-color: #b2ebf2;
}

.map-th:first-child {
    background-color: #ff6e40;
}

.map-tr {
    background-color: #f5f5f5;
    transition: background-color 0.3s;
}

.map-tr:hover {
    background-color: #00c853;
}
</style>