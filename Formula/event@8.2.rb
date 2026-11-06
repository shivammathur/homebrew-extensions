# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "d93833f865fda6d7c93b53a4264068d7ff3e547597c0a7f37a8f1d31751bfd88"
    sha256 cellar: :any, arm64_tahoe:       "968789b35b2878850b2d3b68ad490b3678313131175319d5017a62a77dfb69a2"
    sha256 cellar: :any, arm64_sequoia:     "b9865c795758aceb93e1118586772c17b45958ae0b8f3de975cd33ca96c2b3b3"
    sha256 cellar: :any, arm64_linux:       "cdc2f4584333723e10d4bccf96bcc2861af2eac21110fe063d82949fcc0b7357"
    sha256 cellar: :any, x86_64_linux:      "eefd13e854dcf52b01dddaedb25cc5fb0ed7c8fd3d3d02e4d71eee6a824e6f53"
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
