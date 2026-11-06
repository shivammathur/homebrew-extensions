# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "1ef7a67b8ac0317186e66a5069221a4891dd7cdeac78ae5d2c761b47077d673c"
    sha256 cellar: :any, arm64_tahoe:       "04a8447c1ac39271ada947a242e2cc2a20baf661f00410d0262af29df037b4bb"
    sha256 cellar: :any, arm64_sequoia:     "72d17ce8c5cd9c6bdc3b31d8b7716a62eddf5695617100b226f54b4325304062"
    sha256 cellar: :any, arm64_linux:       "0b6860c391d0115a2f10b8e128835b5f970fa2e3a39717825b8b69049926e43a"
    sha256 cellar: :any, x86_64_linux:      "d059cbfa11f216234ed89234428c42cfaece7c3489ba2740455ee33e1d39fc92"
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
