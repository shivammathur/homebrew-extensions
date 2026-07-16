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
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "a39ae21f2d72cf47c17d8c4059d4db2fadd2d15c0e6390fe089011e548a3b6aa"
    sha256 cellar: :any, arm64_sequoia: "39373edfc5390dcb9d809c7ad138249bc9ece677ab1c10d44978fb5a2c3c57e8"
    sha256 cellar: :any, arm64_sonoma:  "1a1cccb8d059befbb7b4ea0321988371e7696fbf809e3533f1b8af0bd4de42a7"
    sha256 cellar: :any, sonoma:        "7d0812c208b3d96f98495883fddf8e5e38d089a11bf72b609dde9572c8b43403"
    sha256 cellar: :any, arm64_linux:   "48c37203e62ff84197573fd7c361ef900b25af16b539776e3e34886e179c5352"
    sha256 cellar: :any, x86_64_linux:  "e89ffa8a5f7c773a4c265534baf4aae5b21735e8aef7e5e1d40194cda2e6fc55"
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
