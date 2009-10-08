#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define size 8192
/* TODO:
 * sort numerically
 */
int uniq;

struct tnode {
	char *word;
	int count;
	struct tnode *left, *right;
};

struct tnode *addtree(struct tnode *, char *);
void treeprint(struct tnode *);
int getstring(char *);

int main(int argc, char **argv)
{
	int c;
	while (--argc > 0 && (*++argv)[0] == '-')
		while (c = *++argv[0])
			switch(c) {
			case 'u':	uniq = 1;
					break;
			default:	return 1;
			};

	struct tnode *root;
	char word[size];

	root = NULL;

	while (getstring(word))
		root = addtree(root, word);
	treeprint(root);

	return 0;
}

int getstring(char *w)
{
	int c, i = 0;

	while (++i < size && (c = getchar()) != '\n')
		*w++ = c;
	*w = '\0';
	return (c == EOF) ? 0 : 1;
}

struct tnode *addtree(struct tnode *p, char *w)
{
	int cond;

	if (p == NULL) {
		p = (struct tnode *) malloc(sizeof(struct tnode));
		p->word = strdup(w);
		p->count = 1;
		p->left = p->right = NULL;
	} else if ((cond = strcmp(w, p->word)) == 0)
		p->count++;
	else if (cond < 0)
		p->left = addtree(p->left, w);
	else
		p->right = addtree(p->right, w);

	return p;
}

void treeprint(struct tnode *p)
{
	int i;

	if (p != NULL) {
		treeprint(p->left);
		if (uniq)
			printf("%4d\t%s\n", p->count, p->word);
		else
			for (i = 0; i < p->count; ++i)
				printf("%s\n", p->word);
		treeprint(p->right);
		free(p->word);
		free(p);
	}
}
