# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT86 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.2.0.tgz"
  sha256 "fb3d4e3c9fdc79125274f2b46461492923edec6b489ed7077973f7e65f41dc1c"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "5cf53ffcd4009c257c23eca76c15c4e5df5d674d34e450cec77e6b9be27941ed"
    sha256 cellar: :any, arm64_tahoe:       "94444cbc0c53c1c10b4c84f79c1cec221fea9b08209d1b94453d47d858ea4344"
    sha256 cellar: :any, arm64_sequoia:     "7e268596a926d664f77074d3a4ca8db522f3a03842f0e84ffe85aff9fa531bbd"
    sha256 cellar: :any, arm64_linux:       "a94d9b98b3960be2b04199ad33bb5a71d3c2c15713ed09d72a6df82738a4fd70"
    sha256 cellar: :any, x86_64_linux:      "7e2320450a64c4bceb032f89349c21aaea2bb785c9d797123c7c715a54cb11ea"
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
