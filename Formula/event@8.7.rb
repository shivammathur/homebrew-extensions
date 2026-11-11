# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "7607cfd2d4c0c081d22681b2b5dc8c3c31bbff6c59aba16fb1a91d94460a936e"
    sha256 cellar: :any, arm64_tahoe:       "19ffbb3914675ea89e3914ab9c54eaf53b23ec0232a54fb290721ddd3d67c7ed"
    sha256 cellar: :any, arm64_sequoia:     "0e2ded0aa111f6016b2f2572c3a158c2081aa8175ef4319ddd25184ad950e12f"
    sha256 cellar: :any, arm64_linux:       "fff00d25e882667f60c5915a09b03bf83b7914d7834b9733597e52f017100c1e"
    sha256 cellar: :any, x86_64_linux:      "62f10f3108581b83dcaa493b0ca027e29aaf8b461c34127b9216ca02d111c68e"
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
