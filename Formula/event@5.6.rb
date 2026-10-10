# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e7a9f4d8cc3f0479865da50fe9831b8473c3792317db26c78a7152209ec50e6e"
    sha256 cellar: :any, arm64_tahoe:       "e9b5816c845e75f75ce92438c95b96dc56f0406605dfbd71b1d2a3547ae72bd4"
    sha256 cellar: :any, arm64_sequoia:     "d5f74b78076ffb9b3cbc080e8dfd2a5076717cf5f40dcda4d17504041d01a1fb"
    sha256 cellar: :any, arm64_linux:       "8de66f48b136f3964a01f170269ad1473cf2d275130718ed2f954e84524ae88a"
    sha256 cellar: :any, x86_64_linux:      "758c8a6e2aef88b0e83580514a9a43f0cf222008742cd398ab94ca535abd9703"
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
