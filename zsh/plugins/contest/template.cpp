#include <cctype>
#include <string>
#include <cstring>
#include <climits>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <sstream>
#include <fstream>
#include <iomanip>
#include <vector>
#include <list>
#include <set>
#include <map>
#include <stack>
#include <queue>
#include <algorithm>
#include <utility>
#include <bitset>
#include <limits>

using namespace std;

#define FOREACH(i, c) 	for(__typeof((c).begin()) i = (c).begin(); i != (c).end(); ++i)
#define FOR(i, n) 		  for (int i = 0; i < n; i++)
#define SZ(c) 			    int((c).size())
#define PB(x) 			    push_back(x)
#define MP(x,y)			    make_pair(x,y)
#define ALL(x)			    x.begin(), x.end()
#define RALL(x)			    x.rbegin(), x.rend()
#define READ(x) 		    freopen(x, "r", stdin)
#define WRITE(x) 		    freopen(x, "w", stdout)
#define DREP(x)     	  sort(ALL(x)); x.erase(unique(ALL(x)),x.end())
#define CLEAR(c, v) 	  memset(c, v, sizeof(c))
#define P(x)			      ">>> " << #x << " : " << x << endl
#define C(x) 			      cout << P(x)
#define CC(x) 			    clog << P(x)

struct _ { ios_base::Init i; _() { cin.sync_with_stdio(0); cin.tie(0); } } _;

typedef long long ll;
typedef vector<int> vi;
typedef vector<ll> vl;

const int INF = 0x3f3f3f3f;

int main() {

}
