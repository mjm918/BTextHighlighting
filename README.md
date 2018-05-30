# BTextHighlighting

# Usage

1. Add the two files in your project

2. Create a `NSMutableAttributedString` string :

        NSMutableAttributedString *hl = [[NSMutableAttributedString alloc]initWithString:@"Hello world"];
        
3. And highlight by passing the substring and the color:

        [hl setColorForText:key withColor:[UIColor redColor]];
        
# Available methods:

`-(void)setColorForText:(NSString*) textToFind withColor:(UIColor*) color;`
