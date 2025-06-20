function() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	baseUrl: 'https://bp-se-test-cabcd9b246a5.herokuapp.com',
  }
  if (env == 'dev') {
    config.port_testuser = 'https://bp-se-test-cabcd9b246a5.herokuapp.com';
  }
  else if (env == 'qa') {
    config.port_testuser = 'https://bp-se-test-cabcd9b246a5.herokuapp.com';
  }

  return config;
}
