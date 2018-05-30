# BTextHighlighting

# Usage
Create a `NSMutableAttributedString` string :

        NSMutableAttributedString *hl = [[NSMutableAttributedString alloc]initWithString:@"Hello world"];
        
And highlight by passing the substring and the color:

        [hl setColorForText:key withColor:[UIColor redColor]];
        
# Available methods:

`-(void)setColorForText:(NSString*) textToFind withColor:(UIColor*) color;`
