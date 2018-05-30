//
//  BTextHighLight.m
//  EasySales
//
//  Created by julfi on 25/09/2017.
//  Copyright © 2017 EzTech International Sdn Bhd. All rights reserved.
//

#import "BTextHighLight.h"

@implementation NSMutableAttributedString (Color)

-(void)setColorForText:(NSString*)textToFind withColor:(UIColor*) color
{
    NSRange range = [self.mutableString rangeOfString:textToFind options:NSCaseInsensitiveSearch];
    
    if (range.location == NSNotFound) {
        //TODO: apply algo
        NSString *suggested = [self getSuggestedString:self.mutableString key:textToFind];
        NSRange srange = [self.mutableString rangeOfString:suggested!=nil?suggested:textToFind options:NSCaseInsensitiveSearch];
        if(srange.location != NSNotFound){
            [self addAttribute:NSForegroundColorAttributeName value:color range:srange];
        }
    }else{
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}
-(NSString*)getSuggestedString:(NSString *)main key:(NSString *)keyword{
    NSString *suggested = nil;
    NSArray *split = [main componentsSeparatedByString:@" "];
    for (NSString *str in split){
        float distance = floorf([self LevenshteinAlgo:str withString:keyword]);
        if(distance == 1 || distance == 2){
            suggested = str;
        }
    }
    return suggested;
}
-(float)LevenshteinAlgo:(NSString *)mainString withString:(NSString *)wordToCompare
{
    [mainString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [wordToCompare stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    mainString = [mainString lowercaseString];
    wordToCompare = [wordToCompare lowercaseString];
    
    NSInteger k, i, j, cost, * d, distance;
    
    NSInteger n = [mainString length];
    NSInteger m = [wordToCompare length];
    
    if( n++ != 0 && m++ != 0 ) {
        
        d = malloc( sizeof(NSInteger) * m * n );
        
        
        for( k = 0; k < n; k++)
            d[k] = k;
        
        for( k = 0; k < m; k++)
            d[ k * n ] = k;
        
        
        for( i = 1; i < n; i++ )
            for( j = 1; j < m; j++ ) {
                
                
                if( [mainString characterAtIndex: i-1] ==
                   [wordToCompare characterAtIndex: j-1] )
                    cost = 0;
                else
                    cost = 1;
                
                
                d[ j * n + i ] = [self CstyleMinimum: d [ (j - 1) * n + i ] + 1
                                               andOf: d[ j * n + i - 1 ] +  1
                                               andOf: d[ (j - 1) * n + i - 1 ] + cost ];
                
                
                if( i>1 && j>1 && [mainString characterAtIndex: i-1] ==
                   [wordToCompare characterAtIndex: j-2] &&
                   [mainString characterAtIndex: i-2] ==
                   [wordToCompare characterAtIndex: j-1] )
                {
                    d[ j * n + i] = [self CstyleMinimum: d[ j * n + i ]
                                                  andOf: d[ (j - 2) * n + i - 2 ] + cost ];
                }
            }
        
        distance = d[ n * m - 1 ];
        
        free( d );
        
        return distance;
    }
    return 0.0;
}
-(NSInteger)CstyleMinimum:(NSInteger)a andOf:(NSInteger)b andOf:(NSInteger)c
{
    NSInteger min = a;
    if ( b < min )
        min = b;
    
    if( c < min )
        min = c;
    
    return min;
}

-(NSInteger)CstyleMinimum:(NSInteger)a andOf:(NSInteger)b
{
    NSInteger min=a;
    if (b < min)
        min=b;
    
    return min;
}
@end
