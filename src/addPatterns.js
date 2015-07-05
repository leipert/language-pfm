var _ = require('lodash');

var testMap = [
  {
    name: 'markup.bold',
    ignore: true
  },
  {
    // TODO: Move to own
    name: 'markup.strike',
    order: 0,
    repository: 'emphasis-block'
  },
  {
    name: 'string.emoji.gfm',
    order: 0,
    repository: 'inline-no-emphasis'
  },
  {
    name: 'markup.italic',
    ignore: true
  },
  {
    name: 'markup.code',
    ignore: true
  },
  {
    name: 'markup.raw',
    ignore: true
  },
  {
    name: 'constant.character',
    order: 100,
    repository: 'inline-no-emphasis'
  },
  {
    name: 'front-matter.yaml',
    order: 0,
    repository: 'block-no-emphasis'
  },
  {
    name: 'comment.hr',
    order: 0,
    repository: 'single-line'
  },
  {
    name: 'link',
    order: 0,
    repository: 'inline-no-emphasis'
  },
  {
    name: 'comment.quote',
    order: 0,
    repository: 'block-no-emphasis'
  },
  {
    name: 'comment.block',
    order: 0,
    repository: 'block-no-emphasis'
  },
  {
    name: 'table.gfm',
    order: 0,
    repository: 'block-no-emphasis'
  },
  {
    name: 'critic.gfm',
    order: 0,
    repository: 'block-no-emphasis'
  },
  {
    name: 'variable.unordered',
    order: 0,
    repository: 'single-line'
  },
  {
    name: 'variable.ordered',
    ignore: true
  },
  {
    name: 'variable.mention',
    order: 0,
    repository: 'citations'
  },
  {
    name: 'variable.issue',
    order: 0,
    repository: 'inline-no-emphasis'
  },
  {
    name: 'linebreak',
    order: 0,
    repository: 'inline-no-emphasis'
  }
]


module.exports = function(ret) {

  ret.patterns = _.chain(ret.patterns)
    .map(function(p) {
      var name = p.name || _.get(p, 'captures.1.name', false)
      if (name) {
        var rule = _.find(testMap, function(r) {
          return _.startsWith(name, r.name);
        });
        if (rule) {
          if(rule.ignore){
            return false;
          }
          p.order = rule.order
          if (ret.repository.hasOwnProperty(rule.repository)) {
            ret.repository[rule.repository].patterns.push(p);
          } else {
            console.warn('Repository missing: ' + rule.repository);
          }
          return false
        } else {
          console.warn('Mapping missing for ' + name);
          return p;
        }
      } else if (!p.include) {
        console.warn(p);
      }
      return p;
    })
    .compact()
    .value();

  return ret;

}
