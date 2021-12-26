$filename = 'README.md'

try { Remove-Item $filename }
catch { }

new-item $filename

Add-Content '# Notes on Relational Databases and SQL' -Path $filename
Add-Content '' -Path $filename
Add-Content 'Here we have my rough set of notes on relational databases and SQL.' -Path $filename
Add-Content '' -Path $filename
Add-Content '## Table of Contents' -Path $filename

# Get all markdown files excluding the $filename
$notes = @()

foreach ($item in (Get-ChildItem *.md)){
    if ($item.Name -ne $filename){
         $notes += $item;
    }
}

# for each file find the start and end line of the toc
$fname_start_end_toc = @()
function find-emptyline{
    param (
        [int]$s_index,
        [string[]]$list_of_lines
    )
    $t_line = $list_of_lines[$s_index]
    do {
        $s_index += 1
        $t_line = $list_of_lines[$s_index]
    } while ($t_line)
    return $s_index
}

foreach ($item in $notes){

    $start_line = -1;
    $end_line = -1;

    $content = Get-Content $item -TotalCount 100;
    $counter = 0;

    # Find the start line and the end line of the contents
    foreach ($line in $content){
        $start_chars = [string]::Join("", $line[0..1]);

        if ($start_chars -eq '# '){
            $start_line = $counter;
            $start_line = (find-emptyline $start_line $content) + 1
        }
        if ($start_chars -eq '##'){
            $end_line = $counter;
            $end_line = (find-emptyline $end_line $content) - 3
        }

        $counter += 1;

        if (($start_line -ne -1) -and ($end_line -ne -1) ){
            break;
        }
    }
    if ($start_line -eq -1 -or $end_line -eq -1){
        throw "Either the start block or end block of the toc could not be found"
    }

    $fname_start_end_toc += , @($item, $start_line, $end_line)
}

# now foreach file we can grab its table of contents and add it to our created $file

foreach ($item in $fname_start_end_toc) {
    $fpath      = $item[0]
    $fname      = $fpath.Name
    $start_line = $item[1]
    $end_line   = $item[2]

    $content = (Get-Content $fpath)[$start_line..($end_line)]

    $header_regex = [regex] "\[(.+)\]"
    $tag_regex    = [regex] "\((.+)\)"

    foreach ($item in $content) {

        $match_header = $header_regex.Match($item)
        $match_tag    = $tag_regex.Match($item)

        $header_text = $match_header.Groups[1].value
        $tag_text    = $match_tag.Groups[1].value

        $level = 0
        foreach ($i in (0..$item.Length)) {
            if ($item[$i] -eq " "){
                $level += 1;
            } else { break; }
        }
        $toc_string = " "*($level) + "-" + " [$header_text]" + "($fname$tag_text)"
        Add-Content -value $toc_string -Path $filename
    }
}