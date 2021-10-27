// const ids = require("webpack");
function FollowToggle(userId, initialFollowState) {
  let button = $('.follow-toggle');
  this.userId = button.data('user-id');
  this.followState = button.data('initial-follow-state');

}
const buttonInstance = $('button');

module.exports = FollowToggle;