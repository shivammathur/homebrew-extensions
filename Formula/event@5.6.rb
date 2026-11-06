# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "f735be6d48a57f0ba8a22bb4710b61f1d8a423c16e9aecd007c054ed46c16e82"
    sha256 cellar: :any, arm64_tahoe:       "3c993e9aacade6ed146893dae4ae1c32ddffceb7940968094e1bd1d3ce3bb1be"
    sha256 cellar: :any, arm64_sequoia:     "764f06f2e34157201d1d71792f05fb8d156956f5915364541c3c503bfb0b6318"
    sha256 cellar: :any, arm64_linux:       "5adf64a559685738834ae73c6362acac9f0dd46180f04bb1a8ab9fe0940e0cad"
    sha256 cellar: :any, x86_64_linux:      "6788e32b7a19bd24a575fa48b595db9621f55727a63013b04360dc04e8889f21"
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
