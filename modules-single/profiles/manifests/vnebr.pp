class profiles::vnebr {

  include housekeeping::rbenv
  include rbenv
  rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
  rbenv::build { '1.9.3-p551': global => true }
  #rbenv::gem { 'puppet -v 3.8.4': ruby_version => '1.9.3-p551' }
  #rbenv::gem { 'puppet': ruby_version => '1.9.3-p551' } 
  rbenv::gem { 'r10k': ruby_version => '1.9.3-p551' } 

}
