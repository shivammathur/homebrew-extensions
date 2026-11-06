# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "ad5bb8c374b862b0b889e6894cdbe497f8a1a264165d51938347298bc501114f"
    sha256 cellar: :any, arm64_tahoe:       "121e4fc818958cfea7a00cf8b1b2439ec840c2a12c0c83533a4b7d30b0eeb3f5"
    sha256 cellar: :any, arm64_sequoia:     "d30617594e9f233acc013f4b379cca3b233ab6369b9a02c7d22e9269f578da1d"
    sha256 cellar: :any, arm64_linux:       "e5c22887135ef49ee1423ee207214af90b9ef15919dd7a66a4994916ec0fc1a3"
    sha256 cellar: :any, x86_64_linux:      "faf860154e9ce1c4e78450e450733ce30338593af9737de5e3658f63d56738d8"
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
