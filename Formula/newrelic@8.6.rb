# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT86 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.11.0.40.tar.gz"
  sha256 "1d14f9b4e295d5d0dc3dd21f5d713359d1148dda72c0edb124f193ebe076fbc9"
  revision 2
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "279e7bfdb4f753ecb2ddf3b5beaaa116f0135103714b134439e269f3cdf111f4"
    sha256 cellar: :any, arm64_tahoe:       "dfe18e4f23eaac02ec93547c69ce8695aac9b7626d3d1c26242033f45b0bc895"
    sha256 cellar: :any, arm64_sequoia:     "3275b80232a34a57f8122ed6a074b9fc345aa932927f5d0ee866bc6817e09fca"
    sha256 cellar: :any, arm64_linux:       "c67296e9482daa8d333a55550e117a56010e30c8af6445594137106356f1f4a4"
    sha256 cellar: :any, x86_64_linux:      "1cae12ceac322da86cda1ea8eb9dff9177c4b741644f2270b8c67018276b8281"
  end

  # for pcre_compile
  depends_on "pcre"

  # for the agent
  depends_on "protobuf-c"

  # for aclocal + glibtoolize
  depends_on "automake" => :build
  depends_on "libtool" => :build

  # for the daemon
  depends_on "go" => :build

  def config_file_content
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      newrelic.daemon.location="#{prefix}/daemon"
      newrelic.daemon.address="/tmp/.newrelic86.sock"
      newrelic.daemon.port="/tmp/.newrelic86.sock"
      newrelic.logfile="/var/log/newrelic_php_agent.log"
      newrelic.daemon.logfile="/var/log/newrelic_daemon.log"
    EOS
  rescue error
    raise error
  end

  def install
    inreplace "agent/config.m4", "-l:libprotobuf-c.a", "-lprotobuf-c"
    inreplace "axiom/Makefile", "AXIOM_CFLAGS += -Wimplicit-fallthrough", "#AXIOM_CFLAGS += -Wimplicit-fallthrough"
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    inreplace "agent/php_txn.h",
              "nr_php_txn_get_supported_security_policy_settings();",
              "nr_php_txn_get_supported_security_policy_settings(nrtxnopt_t* opts);"
    inreplace "agent/php_txn_private.h",
              "nr_php_txn_get_supported_security_policy_settings();",
              "nr_php_txn_get_supported_security_policy_settings(nrtxnopt_t* opts);"
    inreplace %w[
      agent/fw_cakephp.c
      agent/fw_wordpress.c
      agent/lib_aws_sdk_php.c
      agent/lib_composer.c
      agent/lib_php_amqplib.c
    ], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "agent/php_api.c", "php_verror(docref, params, E_WARNING, format, args TSRMLS_CC)",
              "php_verror(docref, E_WARNING, format, args)"
    inreplace "agent/php_txn.c", "INI_BOOL(", "zend_ini_bool_literal("
    on_macos do
      inreplace "agent/config.m4", "-Wl,-flat_namespace -static-libgcc", "-Wl,-flat_namespace"
    end
    system "make", "-C", "axiom", "v1.pb-c.c"
    system "make", "all", "BUILD_NUMBER=#{version.to_s.split(".").last}"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end

  test do
    assert_match version.to_s, shell_output("#{prefix}/daemon --version")
    output = shell_output("#{formula_opt_bin(php_formula)}/php -n -d extension=#{prefix}/newrelic.so " \
                          "-d newrelic.enabled=0 -r 'echo phpversion(\"newrelic\");'")
    assert_equal version.to_s, output
  end
end
