node 'pnode1.autech.com.au' {
      
  hiera_include('classes')

}
node 'pnode2.autech.com.au' {

  hiera_include('classes')  

}
  class linux {
	
	$admintools = ['git','nano', 'screen']
	
	package { $admintools:
		ensure => 'installed',
	}
		
	$ntpservice = $::osfamily ? {
                'redhat' => 'ntpd',
                'debian' => 'ntp',
                default  => 'ntp',
        }

        file { '/info.txt':
                ensure  => 'present',
                content => inline_template("Created by puppet at <%= Time.now %> \n "),
        }
        
	package { 'ntp':
                ensure => 'installed',
        }

        service { $ntpservice:
                ensure => 'running',
                enable => true,
       }	

  }
