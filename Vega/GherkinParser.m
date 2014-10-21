#import "GherkinParser.h"
#import <PEGKit/PEGKit.h>


@interface GherkinParser ()
    
	@property (nonatomic, retain) NSMutableDictionary *feature;
	@property (nonatomic, retain) NSMutableArray *targetStack;

@property (nonatomic, retain) NSMutableDictionary *feature_memo;
@property (nonatomic, retain) NSMutableDictionary *description_memo;
@property (nonatomic, retain) NSMutableDictionary *description_line_memo;
@property (nonatomic, retain) NSMutableDictionary *background_memo;
@property (nonatomic, retain) NSMutableDictionary *scenarios_memo;
@property (nonatomic, retain) NSMutableDictionary *scenario_memo;
@property (nonatomic, retain) NSMutableDictionary *scenario_outline_memo;
@property (nonatomic, retain) NSMutableDictionary *steps_memo;
@property (nonatomic, retain) NSMutableDictionary *step_memo;
@property (nonatomic, retain) NSMutableDictionary *clause_memo;
@property (nonatomic, retain) NSMutableDictionary *title_memo;
@property (nonatomic, retain) NSMutableDictionary *given_clause_memo;
@property (nonatomic, retain) NSMutableDictionary *when_clause_memo;
@property (nonatomic, retain) NSMutableDictionary *then_clause_memo;
@property (nonatomic, retain) NSMutableDictionary *and_clause_memo;
@property (nonatomic, retain) NSMutableDictionary *pattern_memo;
@property (nonatomic, retain) NSMutableDictionary *element_memo;
@property (nonatomic, retain) NSMutableDictionary *eol_memo;
@property (nonatomic, retain) NSMutableDictionary *data_table_memo;
@property (nonatomic, retain) NSMutableDictionary *data_line_memo;
@property (nonatomic, retain) NSMutableDictionary *cell_memo;
@property (nonatomic, retain) NSMutableDictionary *cell_content_memo;
@property (nonatomic, retain) NSMutableDictionary *cell_number_memo;
@property (nonatomic, retain) NSMutableDictionary *cell_string_memo;
@property (nonatomic, retain) NSMutableDictionary *cell_end_memo;
@property (nonatomic, retain) NSMutableDictionary *tags_memo;
@property (nonatomic, retain) NSMutableDictionary *tag_memo;
@property (nonatomic, retain) NSMutableDictionary *example_table_memo;
@end

@implementation GherkinParser { }
    

- (void)push:(id)object
{
	[self.targetStack addObject:object];
}

- (id)pop 
{
	id top = [self.targetStack lastObject];
	if (top) {
		[self.targetStack removeLastObject];
	}	
	return top;	
}

- (id)peek
{
	return [self.targetStack lastObject];
}	


- (instancetype)initWithDelegate:(id)d {
    self = [super initWithDelegate:d];
    if (self) {
            
	
	self.targetStack = [NSMutableArray array];


        self.startRuleName = @"feature";
        self.tokenKindTab[@"Example"] = @(GHERKINPARSER_TOKEN_KIND_EXAMPLE);
        self.tokenKindTab[@":"] = @(GHERKINPARSER_TOKEN_KIND_COLON);
        self.tokenKindTab[@"Feature"] = @(GHERKINPARSER_TOKEN_KIND_FEATURE);
        self.tokenKindTab[@"<"] = @(GHERKINPARSER_TOKEN_KIND_LT_SYM);
        self.tokenKindTab[@"Scenario"] = @(GHERKINPARSER_TOKEN_KIND_SCENARIO);
        self.tokenKindTab[@"Given"] = @(GHERKINPARSER_TOKEN_KIND_GIVEN);
        self.tokenKindTab[@"And"] = @(GHERKINPARSER_TOKEN_KIND_AND);
        self.tokenKindTab[@"Outline"] = @(GHERKINPARSER_TOKEN_KIND_OUTLINE);
        self.tokenKindTab[@">"] = @(GHERKINPARSER_TOKEN_KIND_GT_SYM);
        self.tokenKindTab[@"When"] = @(GHERKINPARSER_TOKEN_KIND_WHEN);
        self.tokenKindTab[@"\r"] = @(GHERKINPARSER_TOKEN_KIND__R);
        self.tokenKindTab[@"Then"] = @(GHERKINPARSER_TOKEN_KIND_THEN);
        self.tokenKindTab[@"|"] = @(GHERKINPARSER_TOKEN_KIND_PIPE);
        self.tokenKindTab[@"\n"] = @(GHERKINPARSER_TOKEN_KIND__N);
        self.tokenKindTab[@"Background"] = @(GHERKINPARSER_TOKEN_KIND_BACKGROUND);
        self.tokenKindTab[@"@"] = @(GHERKINPARSER_TOKEN_KIND_AT);

        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_EXAMPLE] = @"Example";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_COLON] = @":";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_FEATURE] = @"Feature";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_LT_SYM] = @"<";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_SCENARIO] = @"Scenario";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_GIVEN] = @"Given";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_AND] = @"And";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_OUTLINE] = @"Outline";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_GT_SYM] = @">";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_WHEN] = @"When";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND__R] = @"\r";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_THEN] = @"Then";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_PIPE] = @"|";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND__N] = @"\n";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_BACKGROUND] = @"Background";
        self.tokenKindNameTab[GHERKINPARSER_TOKEN_KIND_AT] = @"@";

        self.feature_memo = [NSMutableDictionary dictionary];
        self.description_memo = [NSMutableDictionary dictionary];
        self.description_line_memo = [NSMutableDictionary dictionary];
        self.background_memo = [NSMutableDictionary dictionary];
        self.scenarios_memo = [NSMutableDictionary dictionary];
        self.scenario_memo = [NSMutableDictionary dictionary];
        self.scenario_outline_memo = [NSMutableDictionary dictionary];
        self.steps_memo = [NSMutableDictionary dictionary];
        self.step_memo = [NSMutableDictionary dictionary];
        self.clause_memo = [NSMutableDictionary dictionary];
        self.title_memo = [NSMutableDictionary dictionary];
        self.given_clause_memo = [NSMutableDictionary dictionary];
        self.when_clause_memo = [NSMutableDictionary dictionary];
        self.then_clause_memo = [NSMutableDictionary dictionary];
        self.and_clause_memo = [NSMutableDictionary dictionary];
        self.pattern_memo = [NSMutableDictionary dictionary];
        self.element_memo = [NSMutableDictionary dictionary];
        self.eol_memo = [NSMutableDictionary dictionary];
        self.data_table_memo = [NSMutableDictionary dictionary];
        self.data_line_memo = [NSMutableDictionary dictionary];
        self.cell_memo = [NSMutableDictionary dictionary];
        self.cell_content_memo = [NSMutableDictionary dictionary];
        self.cell_number_memo = [NSMutableDictionary dictionary];
        self.cell_string_memo = [NSMutableDictionary dictionary];
        self.cell_end_memo = [NSMutableDictionary dictionary];
        self.tags_memo = [NSMutableDictionary dictionary];
        self.tag_memo = [NSMutableDictionary dictionary];
        self.example_table_memo = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)clearMemo {
    [_feature_memo removeAllObjects];
    [_description_memo removeAllObjects];
    [_description_line_memo removeAllObjects];
    [_background_memo removeAllObjects];
    [_scenarios_memo removeAllObjects];
    [_scenario_memo removeAllObjects];
    [_scenario_outline_memo removeAllObjects];
    [_steps_memo removeAllObjects];
    [_step_memo removeAllObjects];
    [_clause_memo removeAllObjects];
    [_title_memo removeAllObjects];
    [_given_clause_memo removeAllObjects];
    [_when_clause_memo removeAllObjects];
    [_then_clause_memo removeAllObjects];
    [_and_clause_memo removeAllObjects];
    [_pattern_memo removeAllObjects];
    [_element_memo removeAllObjects];
    [_eol_memo removeAllObjects];
    [_data_table_memo removeAllObjects];
    [_data_line_memo removeAllObjects];
    [_cell_memo removeAllObjects];
    [_cell_content_memo removeAllObjects];
    [_cell_number_memo removeAllObjects];
    [_cell_string_memo removeAllObjects];
    [_cell_end_memo removeAllObjects];
    [_tags_memo removeAllObjects];
    [_tag_memo removeAllObjects];
    [_example_table_memo removeAllObjects];
}

- (void)start {

    [self feature_]; 
    [self matchEOF:YES]; 

}

- (void)__feature {
    
    [self execute:^{
    

	PKTokenizer *t = self.tokenizer;

    [t.whitespaceState setWhitespaceChars:NO from:'\n' to:'\n'];
    [t.whitespaceState setWhitespaceChars:NO from:'\r' to:'\r'];
    [t setTokenizerState:t.symbolState from:'\n' to:'\n'];
    [t setTokenizerState:t.symbolState from:'\r' to:'\r'];

	[t setTokenizerState:t.wordState from:'!' to:'!'];
	[t setTokenizerState:t.wordState from:'#' to:'/'];
	[t setTokenizerState:t.wordState from:'<' to:'@'];
	[t setTokenizerState:t.wordState from:'[' to:'`'];
    
	self.feature = [NSMutableDictionary dictionary];
	[self push:self.feature];

    }];
    [self tags_]; 
    [self match:GHERKINPARSER_TOKEN_KIND_FEATURE discard:YES]; 
    [self title_]; 
    [self description_]; 
    [self background_]; 
    [self scenarios_]; 
    [self execute:^{
    
	NSString* description = POP_STR();
	self.feature[@"description"] = description;

    }];
    [self execute:^{
    
	PUSH([self pop]);

    }];

}

- (void)feature_ {
    [self parseRule:@selector(__feature) withMemo:_feature_memo];
}

- (void)__description {
    
    if ([self predicts:GHERKINPARSER_TOKEN_KIND_LT_SYM, GHERKINPARSER_TOKEN_KIND__N, GHERKINPARSER_TOKEN_KIND__R, TOKEN_KIND_BUILTIN_NUMBER, TOKEN_KIND_BUILTIN_QUOTEDSTRING, TOKEN_KIND_BUILTIN_WORD, 0]) {
        [self description_line_]; 
        [self description_]; 
        [self execute:^{
        
	NSString *s = POP_STR();
	NSString *e = POP_STR();
	if (e != nil) {
		s = [NSString stringWithFormat:@"%@ %@", e, s];
	}
	PUSH(s);
	

        }];
    } else {
        [self matchEmpty:NO]; 
        [self execute:^{
        
	

        }];
    }

}

- (void)description_ {
    [self parseRule:@selector(__description) withMemo:_description_memo];
}

- (void)__description_line {
    
    [self element_]; 

}

- (void)description_line_ {
    [self parseRule:@selector(__description_line) withMemo:_description_line_memo];
}

- (void)__background {
    
    [self execute:^{
    
	NSMutableDictionary *feature = [self peek];
	NSMutableDictionary *background = [NSMutableDictionary dictionary];
	feature[@"background"] = background;
	[self push:background];

    }];
    [self match:GHERKINPARSER_TOKEN_KIND_BACKGROUND discard:YES]; 
    [self title_]; 
    [self steps_]; 
    [self execute:^{
    
	[self pop];

    }];

}

- (void)background_ {
    [self parseRule:@selector(__background) withMemo:_background_memo];
}

- (void)__scenarios {
    
    [self execute:^{
    
	NSMutableDictionary *feature = [self peek];
	NSMutableArray *scenarios = [NSMutableArray array];
	feature[@"scenarios"] = scenarios;
	[self push:scenarios];

    }];
    while ([self speculate:^{ if ([self speculate:^{ [self scenario_]; }]) {[self scenario_]; } else if ([self speculate:^{ [self scenario_outline_]; }]) {[self scenario_outline_]; } else {[self raise:@"No viable alternative found in rule 'scenarios'."];}}]) {
        if ([self speculate:^{ [self scenario_]; }]) {
            [self scenario_]; 
        } else if ([self speculate:^{ [self scenario_outline_]; }]) {
            [self scenario_outline_]; 
        } else {
            [self raise:@"No viable alternative found in rule 'scenarios'."];
        }
    }
    [self execute:^{
    
	[self pop];

    }];

}

- (void)scenarios_ {
    [self parseRule:@selector(__scenarios) withMemo:_scenarios_memo];
}

- (void)__scenario {
    
    [self execute:^{
    
	NSMutableArray *scenarios = [self peek];
	NSMutableDictionary *scenario = [NSMutableDictionary dictionary];
	[scenarios addObject:scenario];
	[self push:scenario];	

    }];
    [self tags_]; 
    [self match:GHERKINPARSER_TOKEN_KIND_SCENARIO discard:YES]; 
    [self title_]; 
    [self steps_]; 
    [self execute:^{
    
	[self pop];

    }];

}

- (void)scenario_ {
    [self parseRule:@selector(__scenario) withMemo:_scenario_memo];
}

- (void)__scenario_outline {
    
    [self execute:^{
    
	NSMutableArray *scenarios = [self peek];
	NSMutableDictionary *scenario_outline = [NSMutableDictionary dictionary];
	[scenarios addObject:scenario_outline];
	[self push:scenario_outline];	

    }];
    [self tags_]; 
    [self match:GHERKINPARSER_TOKEN_KIND_OUTLINE discard:YES]; 
    [self title_]; 
    [self steps_]; 
    [self example_table_]; 
    [self execute:^{
    
	NSMutableDictionary *scenario = [self peek];
	scenario[@"outline"] = @(YES);
	scenario[@"example"] = POP();

    }];
    [self execute:^{
    
	[self pop];

    }];

}

- (void)scenario_outline_ {
    [self parseRule:@selector(__scenario_outline) withMemo:_scenario_outline_memo];
}

- (void)__steps {
    
    [self execute:^{
    
	NSMutableDictionary *scenario = [self peek];
	NSMutableArray *steps = [NSMutableArray array];
	scenario[@"steps"] = steps;

    }];
    do {
        [self step_]; 
    } while ([self speculate:^{ [self step_]; }]);

}

- (void)steps_ {
    [self parseRule:@selector(__steps) withMemo:_steps_memo];
}

- (void)__step {
    
    if ([self speculate:^{ [self clause_]; [self data_table_]; }]) {
        [self clause_]; 
        [self data_table_]; 
        [self execute:^{
        
	NSMutableDictionary *scenario = [self peek];
	NSArray* data_table = POP();
	NSString *method  = POP_STR();
	NSString *pattern = POP_STR();
	NSDictionary *clause = @{@"method": method, 
							 @"pattern":pattern,
							 @"data":   data_table};
	[scenario[@"steps"] addObject:clause];

        }];
    } else if ([self speculate:^{ [self clause_]; }]) {
        [self clause_]; 
        [self execute:^{
        
	NSMutableDictionary *scenario = [self peek];
	NSString *method  = POP_STR();
	NSString *pattern = POP_STR();
	NSDictionary *clause = @{@"method": method, 
							 @"pattern":pattern};
	[scenario[@"steps"] addObject:clause];

        }];
    } else {
        [self raise:@"No viable alternative found in rule 'step'."];
    }

}

- (void)step_ {
    [self parseRule:@selector(__step) withMemo:_step_memo];
}

- (void)__clause {
    
    if ([self predicts:GHERKINPARSER_TOKEN_KIND_GIVEN, 0]) {
        [self given_clause_]; 
    } else if ([self predicts:GHERKINPARSER_TOKEN_KIND_WHEN, 0]) {
        [self when_clause_]; 
    } else if ([self predicts:GHERKINPARSER_TOKEN_KIND_THEN, 0]) {
        [self then_clause_]; 
    } else if ([self predicts:GHERKINPARSER_TOKEN_KIND_AND, 0]) {
        [self and_clause_]; 
    } else {
        [self raise:@"No viable alternative found in rule 'clause'."];
    }

}

- (void)clause_ {
    [self parseRule:@selector(__clause) withMemo:_clause_memo];
}

- (void)__title {
    
    [self match:GHERKINPARSER_TOKEN_KIND_COLON discard:YES]; 
    [self element_]; 
    [self execute:^{
    
	NSString *s = POP_STR();
	NSMutableDictionary *featureOrScenario = [self peek];
	featureOrScenario[@"title"] = s;

    }];

}

- (void)title_ {
    [self parseRule:@selector(__title) withMemo:_title_memo];
}

- (void)__given_clause {
    
    [self match:GHERKINPARSER_TOKEN_KIND_GIVEN discard:NO]; 
    [self pattern_]; 

}

- (void)given_clause_ {
    [self parseRule:@selector(__given_clause) withMemo:_given_clause_memo];
}

- (void)__when_clause {
    
    [self match:GHERKINPARSER_TOKEN_KIND_WHEN discard:NO]; 
    [self pattern_]; 

}

- (void)when_clause_ {
    [self parseRule:@selector(__when_clause) withMemo:_when_clause_memo];
}

- (void)__then_clause {
    
    [self match:GHERKINPARSER_TOKEN_KIND_THEN discard:NO]; 
    [self pattern_]; 

}

- (void)then_clause_ {
    [self parseRule:@selector(__then_clause) withMemo:_then_clause_memo];
}

- (void)__and_clause {
    
    [self match:GHERKINPARSER_TOKEN_KIND_AND discard:NO]; 
    [self pattern_]; 

}

- (void)and_clause_ {
    [self parseRule:@selector(__and_clause) withMemo:_and_clause_memo];
}

- (void)__pattern {
    
    [self element_]; 

}

- (void)pattern_ {
    [self parseRule:@selector(__pattern) withMemo:_pattern_memo];
}

- (void)__element {
    
    if ([self predicts:GHERKINPARSER_TOKEN_KIND_LT_SYM, 0]) {
        [self match:GHERKINPARSER_TOKEN_KIND_LT_SYM discard:YES]; 
        [self matchWord:NO]; 
        [self match:GHERKINPARSER_TOKEN_KIND_GT_SYM discard:YES]; 
        [self element_]; 
        [self execute:^{
        
	NSString *s = POP_STR();
	NSString *e = [NSString stringWithFormat:@"<%@>",POP_STR()];
	if ([s length] > 0) {
		e = [NSString stringWithFormat:@"%@ %@", e, s];
	}
	PUSH(e);

        }];
    } else if ([self predicts:TOKEN_KIND_BUILTIN_WORD, 0]) {
        [self matchWord:NO]; 
        [self element_]; 
        [self execute:^{
        
	NSString *s = POP_STR();
	NSString *e = POP_STR();
	if ([s length] > 0) {
		e = [NSString stringWithFormat:@"%@ %@", e, s];
	}
	PUSH(e);

        }];
    } else if ([self predicts:TOKEN_KIND_BUILTIN_QUOTEDSTRING, 0]) {
        [self matchQuotedString:NO]; 
        [self element_]; 
        [self execute:^{
        
	NSString *s = POP_STR();
	NSString *e = POP_STR();
	if ([s length] > 0) {
		e = [NSString stringWithFormat:@"%@ %@", e, s];
	}
	PUSH(e);


        }];
    } else if ([self predicts:TOKEN_KIND_BUILTIN_NUMBER, 0]) {
        [self matchNumber:NO]; 
        [self element_]; 
        [self execute:^{
        
	NSString *s = POP_STR();
	NSString *e = POP_STR();
	if ([s length] > 0) {
		e = [NSString stringWithFormat:@"%@ %@", e, s];
	}
	PUSH(e);

        }];
    } else if ([self predicts:GHERKINPARSER_TOKEN_KIND__N, GHERKINPARSER_TOKEN_KIND__R, 0]) {
        do {
            [self eol_]; 
        } while ([self predicts:GHERKINPARSER_TOKEN_KIND__N, GHERKINPARSER_TOKEN_KIND__R, 0]);
        [self execute:^{
        
	PUSH(@"");

        }];
    } else {
        [self raise:@"No viable alternative found in rule 'element'."];
    }

}

- (void)element_ {
    [self parseRule:@selector(__element) withMemo:_element_memo];
}

- (void)__eol {
    
    if ([self predicts:GHERKINPARSER_TOKEN_KIND__N, 0]) {
        [self match:GHERKINPARSER_TOKEN_KIND__N discard:YES]; 
    } else if ([self predicts:GHERKINPARSER_TOKEN_KIND__R, 0]) {
        [self match:GHERKINPARSER_TOKEN_KIND__R discard:YES]; 
    } else {
        [self raise:@"No viable alternative found in rule 'eol'."];
    }

}

- (void)eol_ {
    [self parseRule:@selector(__eol) withMemo:_eol_memo];
}

- (void)__data_table {
    
    [self execute:^{
    
	NSMutableArray *table = [NSMutableArray array];
	[self push:table];

    }];
    do {
        [self data_line_]; 
    } while ([self speculate:^{ [self data_line_]; }]);
    [self execute:^{
    
	PUSH([self pop]);

    }];

}

- (void)data_table_ {
    [self parseRule:@selector(__data_table) withMemo:_data_table_memo];
}

- (void)__data_line {
    
    [self execute:^{
    
	NSMutableArray *table = [self peek];
	NSMutableArray *line  = [NSMutableArray array];
	[table addObject:line];
	[self push:line];

    }];
    [self match:GHERKINPARSER_TOKEN_KIND_PIPE discard:YES]; 
    do {
        [self cell_]; 
    } while ([self speculate:^{ [self cell_]; }]);
    [self eol_]; 
    [self execute:^{
    
	[self pop];

    }];

}

- (void)data_line_ {
    [self parseRule:@selector(__data_line) withMemo:_data_line_memo];
}

- (void)__cell {
    
    [self cell_content_]; 
    [self execute:^{
    
	NSObject *o = [self.assembly pop];
	NSMutableArray *line = [self peek];
	[line addObject:o];

    }];

}

- (void)cell_ {
    [self parseRule:@selector(__cell) withMemo:_cell_memo];
}

- (void)__cell_content {
    
    if ([self predicts:GHERKINPARSER_TOKEN_KIND_PIPE, TOKEN_KIND_BUILTIN_WORD, 0]) {
        [self cell_string_]; 
    } else if ([self predicts:TOKEN_KIND_BUILTIN_NUMBER, 0]) {
        [self cell_number_]; 
    } else {
        [self raise:@"No viable alternative found in rule 'cell_content'."];
    }

}

- (void)cell_content_ {
    [self parseRule:@selector(__cell_content) withMemo:_cell_content_memo];
}

- (void)__cell_number {
    
    [self matchNumber:NO]; 
    [self cell_end_]; 
    [self execute:^{
    
	NSNumber *n = @(POP_DOUBLE());
	PUSH(n);

    }];

}

- (void)cell_number_ {
    [self parseRule:@selector(__cell_number) withMemo:_cell_number_memo];
}

- (void)__cell_string {
    
    if ([self predicts:TOKEN_KIND_BUILTIN_WORD, 0]) {
        [self matchWord:NO]; 
        [self cell_string_]; 
        [self execute:^{
        
	NSString *s = POP_STR();
	NSString *e = POP_STR();
	if ([s length] > 0) {
		e = [NSString stringWithFormat:@"%@ %@", e, s];
	}
	PUSH(e);

        }];
    } else if ([self predicts:GHERKINPARSER_TOKEN_KIND_PIPE, 0]) {
        [self cell_end_]; 
        [self execute:^{
        
	PUSH(@"");

        }];
    } else {
        [self raise:@"No viable alternative found in rule 'cell_string'."];
    }

}

- (void)cell_string_ {
    [self parseRule:@selector(__cell_string) withMemo:_cell_string_memo];
}

- (void)__cell_end {
    
    [self match:GHERKINPARSER_TOKEN_KIND_PIPE discard:YES]; 

}

- (void)cell_end_ {
    [self parseRule:@selector(__cell_end) withMemo:_cell_end_memo];
}

- (void)__tags {
    
    [self execute:^{
    
	NSMutableDictionary *d = [self peek];
	NSMutableArray *tags = [NSMutableArray array];
	d[@"tags"] = tags;
	[self push:tags];

    }];
    if ([self predicts:GHERKINPARSER_TOKEN_KIND_AT, 0]) {
        do {
            [self tag_]; 
        } while ([self speculate:^{ [self tag_]; }]);
        [self eol_]; 
    }
    [self execute:^{
    
	[self pop];

    }];

}

- (void)tags_ {
    [self parseRule:@selector(__tags) withMemo:_tags_memo];
}

- (void)__tag {
    
    [self match:GHERKINPARSER_TOKEN_KIND_AT discard:YES]; 
    [self matchAny:NO]; 
    [self execute:^{
    
	NSMutableArray *tags = [self peek];
	[tags addObject:POP_STR()];

    }];

}

- (void)tag_ {
    [self parseRule:@selector(__tag) withMemo:_tag_memo];
}

- (void)__example_table {
    
    [self match:GHERKINPARSER_TOKEN_KIND_EXAMPLE discard:YES]; 
    [self match:GHERKINPARSER_TOKEN_KIND_COLON discard:YES]; 
    while ([self predicts:GHERKINPARSER_TOKEN_KIND__N, GHERKINPARSER_TOKEN_KIND__R, 0]) {
        [self eol_]; 
    }
    [self data_table_]; 
    [self execute:^{
    
	
	NSArray *array = POP();
	
	NSMutableDictionary *ex_table = [NSMutableDictionary dictionary];
	
	if ([array count] > 1) {
		NSArray *header = array[0];
		for (int j = 0; j < [header count]; j++) {
			NSString *title = header[j];
			NSMutableArray *currentLine = [NSMutableArray array];
			for (int i=1; i < [array count]; i++) {
				[currentLine addObject:array[i][j]];
			}
			ex_table[title] = currentLine;
			
		}
	}	
	PUSH(ex_table);

    }];

}

- (void)example_table_ {
    [self parseRule:@selector(__example_table) withMemo:_example_table_memo];
}

@end