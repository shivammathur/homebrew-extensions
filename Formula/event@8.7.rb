# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "42106572987c786f22610064d060dcd483d34832f88bc61ad91e80864b5fbf82"
    sha256 cellar: :any, arm64_tahoe:       "524ed5e72e222372f85d557d06cd97de69794734e19270478e5cd773deccc74e"
    sha256 cellar: :any, arm64_sequoia:     "f358800de31ddea930124517ea5d310684647d6b8b8677bfcca4fb3f076be2e5"
    sha256 cellar: :any, arm64_linux:       "220d37de957e2138c79af56403948c070f61b78b8d2e8deb1c4f3803db19d5ff"
    sha256 cellar: :any, x86_64_linux:      "1e1e4801edb48a62c8d052733372b8755fbaf1116909994f05a8d8d5329d0433"
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
