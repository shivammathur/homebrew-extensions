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
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "f7b7fdeb6831d74c36c545919d76459b1282c7974967666333573cdc94031679"
    sha256 cellar: :any, arm64_tahoe:       "d9eea36a773740067a4192d3fc93829792831fcff61b099268eeba9f606a011c"
    sha256 cellar: :any, arm64_sequoia:     "45b00d7252e1b6658c90ead3f5581c8017ba756ebb0fe2bb81979660729f4a73"
    sha256 cellar: :any, arm64_linux:       "20761798679e49b6451af63b00b747fa9f91722488634e9e3ed380d759be1270"
    sha256 cellar: :any, x86_64_linux:      "b7e7d3eaedf2142aad666aff5c149cedd8175aa36cac066521af2ff1c419a819"
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
