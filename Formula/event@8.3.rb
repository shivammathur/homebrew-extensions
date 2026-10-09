# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0feef7998ab82e15ba15c2dc4df8bd5a5a578f1c2c1aa16db7e72ac44e7d1d37"
    sha256 cellar: :any, arm64_tahoe:       "0da183bcc6219340019289216e62ec3a1f90874f65afb66fb8133c9ec10a89aa"
    sha256 cellar: :any, arm64_sequoia:     "89562f890c1508a35846e6862c2c086f9ba1c38eb91978b0c1fb5f75da5d9974"
    sha256 cellar: :any, arm64_linux:       "2b8c525e3276e82cef16338821926c868e5db14152339527e383222dcf9d8ada"
    sha256 cellar: :any, x86_64_linux:      "41ebd9d8376298b8ca579982a5d8ee97a2c1f0cabb708e65b82a6fe202c1568b"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --with-event-libevent-dir=#{Utils::Path.formula_opt_prefix("libevent")}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
