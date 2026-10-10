# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "a65db7394ce7430bfaf8d654215983922ce2be507e60adbde0f9cbbf98a4fac9"
    sha256 cellar: :any, arm64_tahoe:       "0c712ccb38823d93536669c013d81dd46734fddf70ece14f4cd0375e74c95fa8"
    sha256 cellar: :any, arm64_sequoia:     "2757232007087a75edb03f8bdc0931fecb5bff2dba67bd12d65ca8ed0098fea0"
    sha256 cellar: :any, arm64_linux:       "7a0b6916f5fb22ff8ad35e0ffee039b31e078b2c791c27b0e8732c7f5123df86"
    sha256 cellar: :any, x86_64_linux:      "a953afd4b309a551c20d08ebfd93b8b07bd418ca65f01333247386e0929a8e43"
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
