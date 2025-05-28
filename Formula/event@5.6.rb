# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "8a16e159b84c8350760ae0bf6a8b211a5bc90fecf02af9b690ab2d65ed81ea87"
    sha256 cellar: :any,                 arm64_sonoma:   "df21b4d14d2305ef1b3d7132aebe6bf73ce2ab2cca6fe99cac432d19639aedd1"
    sha256 cellar: :any,                 arm64_ventura:  "baf7d044f5e34998e9203b0d87e899cf7356cc901624852864a70ecb5051b050"
    sha256 cellar: :any,                 arm64_monterey: "f2acbbcd4de5429e2e2c3c676fcda9386aa0c7e70947c71b2a6710b10fd574fd"
    sha256 cellar: :any,                 ventura:        "a9bb638f6bb76082bf170b7c8496223717bb31e52a62b042ed95fdbed3ecdb67"
    sha256 cellar: :any,                 monterey:       "2bcf309c238690770cdd333806e1ee9b6c67036e2661d67ee87f50fd326a8d84"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "002f8f4771a179284c681ba176099dc9eb574e4759b98646429d79d2ebbab6e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fec6cef3c68447046a0a6546010e95b42ce9dcba6091489c3dca533bf1c94aba"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
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
