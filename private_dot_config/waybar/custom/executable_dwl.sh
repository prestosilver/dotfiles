conpositor-msg $@ | awk '
{
    print "{\"text\": \"" $0 "\", \"tooltip\": \"\", \"class\": \"\" }";
    system("");
}'
