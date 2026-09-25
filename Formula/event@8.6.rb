# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "dd217429dc6adcf917239ba2f1db84b3bd02292b0e25aa0233ac6704514db384"
    sha256 cellar: :any, arm64_tahoe:       "dec005ab651db9e1bf6a879dcb8ea2cfb03fee5032ecbcc738a9fbb9c9b4ec21"
    sha256 cellar: :any, arm64_sequoia:     "4a1267c64957a448b69548ac0801cf8daf370872a5e89bbdb97235b87db6aafe"
    sha256 cellar: :any, arm64_linux:       "90fa7c2a9c08a215dba94dd54df6dbb55c63a1d86036a87b2a4f57c4c35d66ff"
    sha256 cellar: :any, x86_64_linux:      "15379ee64d5034fc9284d79d979f6b49ab1534f861d5db5692876ff59ff5c304"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
